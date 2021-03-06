class ProductsController < ApplicationController
  include CurrentOrder
  skip_before_action :require_login
  before_action :set_order, only: :addToOrder

  def index

    @category = GalleryCategory.find_by(name: params[:category])

    if @category != nil
      @products = Product.where('archived = ? AND gallery_category_id = ?', false, @category)
    else
      @products = Product.where(archived: false)
    end

    @images = {}
    @products.each do |p|
      image = ItemImage.find(p.primary_image)
      @images[p.id] = image.image_path
    end
  end

  def new
    if !admin?
      redirect_to products_path
    end

    @product = Product.new
  end

  def create
    if !admin?
      redirect_to products_path
    end
    params[:product][:primary_image] = 1;

    @product = Product.new(product_params)
    if @product.save!
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    if !admin?
      redirect_to product_path(params[:id])
    end

    @product = Product.find(params[:id])

    if !@product.order_id.nil?
      if @product.destroy!
        @images = ItemImage.where(product_id: @product.id)

        @images.each do |i|
          i.destroy!
        end
        redirect_to admin_path
      else
        redirect_to edit_product_path(@product)
      end
    end

  end

  def show
    @product = Product.find(params[:id])
    @primaryImage = ItemImage.find(@product.primary_image)
    @images = ItemImage.where(product_id: params[:id])
  end

  def update
    if !admin?
      redirect_to product_path(params[:id])
    end

    @product = Product.find(params[:id])

    if @product.update_attributes!(product_params)
      redirect_to edit_product_path(@product)
    else
      redirect_to edit_product_path(@product)
    end

  end

  def edit
    if !admin?
      redirect_to product_path(params[:id])
    end

    @product = Product.find(params[:id])
    @primaryImage = ItemImage.find(@product.primary_image)
    @images = ItemImage.where(product_id: @product.id)
    @newImage = ItemImage.new
  end

  def addToOrder

    @product = Product.find(params[:id])

    #if the current users order has already been placed we need to create a new one
    if @order.placed?
      @order = Order.create!
      session[:order_id] = @order.id
    end

    if @product.order_id.nil?
      if @product.update_attributes!({order_id: @order.id})
        @order.subtotal = @order.subtotal.nil? ? @product.price : @order.subtotal + @product.price
        @order.save!
        redirect_to product_path(@product)
      else
        flash[:error] = "There was a problem adding the item to your cart"
        redirect :back
      end
    else
      flash[:error] = "This item is no longer available"
      redirect_back(fallback_location: product_path(@product))
    end

  end

  def removeFromOrder
    @product = Product.find(params[:id])

    @order = ::Order.find(@product.order_id)

    if !@order.placed?
      @order.subtotal -= @product.price
      @order.save!
      if @product.update_attributes({order_id: nil})
        redirect_to url_for(controller: 'orders', action: 'show', id: session[:order_id])
      end
    else
      #TODO show error that we can't remove the product because the order is already placed
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :gallery_category_id, :description, :price, :primary_image)
    end
end
