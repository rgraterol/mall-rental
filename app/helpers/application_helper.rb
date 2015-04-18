module ApplicationHelper
    def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def full_title(page_title='')
      base_title= 'Mall Rental'
      page_title.empty? ? base_title : "#{base_title} | #{page_title}"
    end
end
