class ItemImagesController < ApplicationController

  def create
    @image = ItemImage.new(item_image_params)
    product_id = params[:product_id]
    product = Product.find(product_id)

    if @image.save!
      if product.primary_image == 1
        product.primary_image = @image.id
        product.save!
      end
      redirect_to edit_product_path(product_id)
    end
  end

  def destroy
    image_id = params[:id]
    product_id = params[:product_id]
    @product = Product.find(product_id)

    @image = ItemImage.find(image_id)
    if @image.destroy!
      logger.debug "product primary image"+@product.primary_image.to_s
      if ItemImage.where(product_id: @product.id).size == 0
        logger.debug "there's no other images so set to default"
        @product.primary_image = 1
      else
        @product.primary_image = ItemImage.where(product_id: @product.id).first.id
      end
      @product.save!
      redirect_to edit_product_path(@product)
    end

  end

  private
  def item_image_params
    params.require(:item_image).permit(:product_id, :image_path)
  end
end
