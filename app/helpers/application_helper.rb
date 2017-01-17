module ApplicationHelper

  def is_active(action)
    if params[:controller] == "main"
      params[:action] == action ? "active" : nil
    end
  end
  
end
