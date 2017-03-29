class MainController < ApplicationController
  skip_before_action :require_login

  def index
  end

  def about
  end

  def temp_cart
  end

end
