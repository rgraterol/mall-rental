namespace 'permissions' do
  desc "Loading all models and their related controller methods inpermissions table."
  task(:permissions => :environment) do
    arr = []
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        #check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*_?[a-z]*?$/
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/
            arr << "#{entry.titleize.gsub(' ','')}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end
    arr.each do |controller|
      if controller.respond_to?(:permission) && controller != "ApplicationController"
        write_permission(controller.permission, "manage", 'manage')
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+[?|!]?)$/
            name, cancan_action = eval_cancan_action(method)
            unless (name.blank? && cancan_action.blank?) || controller.permission.nil?
              write_permission(controller.permission, cancan_action, name)
            end
          end
        end
      end
    end
  end
end

def eval_cancan_action(action)
  case action.to_s
    when "index"
      name = 'list'
      cancan_action = "index"
          action_desc = I18n.t :list
    when "new", "create"
      name = 'create and update'
      cancan_action = "create"
      action_desc = I18n.t :create
    when "show"
      name = 'view'
      cancan_action = "view"
      action_desc = I18n.t :view
    when "edit", "update"
      name = 'create and update'
      cancan_action = "update"
      action_desc = I18n.t :update
    when "delete", "destroy"
      name = 'delete'
      cancan_action = "destroy"
      action_desc = I18n.t :destroy
    else
      #FUNCIONES NECESARIAS FUERA DEL REST TYPE
      #DEBEN COMENZAR CON EL PREFIJO MF DE MALL FUNCTION
      if action =~ /^mf_/i
        name = action.to_s
        cancan_action = action.to_s
        action_desc = "Other: " < cancan_action
      end
  end
  return name, cancan_action
end

def write_permission(model, cancan_action, name)
  permission = Permission.where(subject_class: model, action: cancan_action).first
  if permission.nil?
    permission = Permission.new
    permission.name = name
    permission.subject_class = model
    permission.action = cancan_action
    permission.save
    puts permission.errors.inspect if permission.errors.any?
  else
    permission.name = name
    permission.save
  end
end