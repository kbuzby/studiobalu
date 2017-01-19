class ProductsController < ApplicationController
  def index
    category = params[:category]
    if category != nil
      @products = Product.where(category: category)
    else
      @products = Product.all
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

    @product = Product.new(product_params)
    if @product.save
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    if !admin?
      redirect_to product_path(params[:id])
    end

    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    if !admin?
      redirect_to product_path(params[:id])
    end

    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to product_path(@product)
    else
      redirect_to edit_product_path(@product)
    end

  end

  def edit
    if !admin?
      redirect_to product_path(params[:id])
    end

    @product = Product.find(params[:id])
  end

  private
    def product_params
      params.require(:post).permit(:name, :category, :description, :price, :image_path)
    end
end
