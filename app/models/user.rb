class User < ActiveRecord::Base
  belongs_to :organization
  has_many :under_organizations, :class_name => "Organization", :foreign_key => "upper_manager_id"
  attr_accessible :displayname, :enabled, :organization_id, :organization, :username, 
    :password, :password_confirmation, :roles, :enable_strict_validation

  has_secure_password
  validates_presence_of :username, :displayname, :organization_id
  validates :password, :presence => true, :on => :create
  validates :password, :presence => true, :if => :enable_strict_validation
  validates_uniqueness_of :username

  ROLES = %w[admin staff department_manager vice_manager general_manager financial_officer banned]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def is_valid?
    !roles.empty?
  end

  def organization_name
    organization ? organization.name : ""
  end

  def enable_strict_validation
    @enable_strict_validation
  end

  def enable_strict_validation=(value)
    @enable_strict_validation = value
  end

  def self.upper_managers
    upper_managers = []
    User.all.each do |u|
      upper_managers << u if u.is?(:vice_manager) or u.is?(:general_manager)
    end
    upper_managers
  end

  def related_organizations_id
    (self.under_organizations.map { |o| o.id } + self.organization.subtree_ids).uniq
  end



  # User.authenticate('username123', 'password123')  # returns authenticated user or nil

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  def self.obtain(id)
    return User.find(id)
  end


  def login_with
    @login_with ||= :username
    self[@login_with]
  end

  def change_password!(current_password)
    raise "Need to set new password first" if @password.blank?

    Devise::LDAP::Adapter.update_own_password(login_with, @password, current_password)
  end
  
  def reset_password!(new_password, new_password_confirmation)
    if new_password == new_password_confirmation && ::Devise.ldap_update_password
      Devise::LDAP::Adapter.update_password(login_with, new_password)
    end
    clear_reset_password_token if valid?
    save
  end

  # !!! Conflicted with has_secure_password !!!
  # def password=(new_password)
  #   @password = new_password
  #   if defined?(password_digest) && @password.present? && respond_to?(:encrypted_password=)
  #     self.encrypted_password = password_digest(@password) 
  #   end
  # end

  # Checks if a resource is valid upon authentication.
  def valid_ldap_authentication?(password)
    if Devise::LDAP::Adapter.valid_credentials?(login_with, password)
      return true
    else
      return false
    end
  end

  def ldap_groups
    Devise::LDAP::Adapter.get_groups(login_with)
  end

  def in_ldap_group?(group_name, group_attribute = LDAP::DEFAULT_GROUP_UNIQUE_MEMBER_LIST_KEY)
    Devise::LDAP::Adapter.in_ldap_group?(login_with, group_name, group_attribute)
  end

  def ldap_dn
    Devise::LDAP::Adapter.get_dn(login_with)
  end

  def ldap_get_param(login_with, param)
    Devise::LDAP::Adapter.get_ldap_param(login_with,param)
  end
end
