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
end
