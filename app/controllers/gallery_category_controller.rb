class GalleryCategoryController < ApplicationController

  def new
    @category = GalleryCategory.new
  end

  def create
    @category = GalleryCategory.new(category_params)

    if @category.save!
      update_category_names
    end

    redirect_to gallery_category_index_path
  end

  def edit
    @category = GalleryCategory.find(params[:id])
  end

  def update
    @category = GalleryCategory.find(params[:id])

    if @category.update_attributes(category_params)
      update_category_names
      redirect_to gallery_category_index_path
    else
      redirect_to edit_gallery_category_path(@category)
    end
  end

  def index
    @categories = GalleryCategory.all
  end

  def destroy
    @category = GalleryCategory.find(params[:id])
    update_category_names
  end

  private
    def category_params
      params.require(:gallery_category).permit(:name, :description)
    end

end
