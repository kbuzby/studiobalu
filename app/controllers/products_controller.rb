class ProductsController < ApplicationController
  skip_before_action :require_login

  def index

    @category = GalleryCategory.find_by(name: params[:category])

    if @category != nil
      @products = Product.where(gallery_category: @category)
    else
      @products = Product.all
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

  private
    def product_params
      params.require(:product).permit(:name, :gallery_category_id, :description, :price, :primary_image)
    end
end
