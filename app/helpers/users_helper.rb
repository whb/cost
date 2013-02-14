module UsersHelper
  def display roles
    display_roles = []
    roles.each do |role|
      display_roles << t("roles.#{role}")
    end
    display_roles
  end
end
