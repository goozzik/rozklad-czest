module ApplicationHelper

  def current_action?(action)
    controller.action_name == action
  end

end
