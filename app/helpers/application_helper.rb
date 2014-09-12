module ApplicationHelper


  def is_active_tab?(page_controller,action)
    if controller.controller_name == page_controller &&
                                    controller.action_name == action
      "active"
    else
      false
    end
  end


end
