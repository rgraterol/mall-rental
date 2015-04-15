class Ability
  include CanCan::Ability

  def initialize(user)
    if user && !user.locked
      user.role.permissions.each do |permission|
        if permission.subject_class == "all"
          can permission.action.to_sym, permission.subject_class.to_sym
        elsif (permission.subject_class.constantize rescue nil).nil?
          can permission.action.to_sym, permission.subject_class.to_sym rescue nil
        else
          can permission.action.to_sym, permission.subject_class.constantize rescue nil
        end
      end
    end
  end

end
