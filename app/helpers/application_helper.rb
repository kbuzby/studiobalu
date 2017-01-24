module ApplicationHelper

  def is_active(action)
    controller = params[:controller]
    paramAction = params[:action]
    if controller == 'main'
      paramAction == action ? 'active' : nil
    elsif controller == 'sessions'
      (action == 'admin' && paramAction == 'show') ? 'active' : nil
    elsif controller == 'products'
      action == 'gallery' ? 'active' : nil
    end
  end

end
