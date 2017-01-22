class MainController < ApplicationController
  skip_before_action :require_login

  def index
  end

  def about
    content = Content.find_by(:name => 'about')
    if !content.nil?
      @content = content
    end
  end

  def contact
  end

end
