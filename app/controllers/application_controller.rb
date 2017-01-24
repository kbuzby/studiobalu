class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include ApplicationHelper

  before_action :require_login
  before_action :category_names

  def update_category_names
    @category_names = GalleryCategory.pluck(:name)
  end

  def category_names
    @category_names ||= update_category_names
  end

  private
    def require_login
      unless current_user
        redirect_to login_path
      end
    end
end
