class SetPrimaryDefault < ActiveRecord::Migration[5.0]
  def change
    @products = Product.all
    @products.each do |p|
      p.primary_image = 1
      p.save!
    end

    @images = ItemImage.all
    @images.each do |img|
      if img.id != 1
        if !img.image_path.file.nil?
          product = Product.find(img.product_id)
          product.primary_image = img.id
          product.save!
        else
          img.destroy!
        end
      end
    end
  end
end
