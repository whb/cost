class User < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :displayname, :enabled, :organization_id, :username, :password, :password_confirmation, :roles

  has_secure_password
  validates_presence_of :username, :displayname, :organization_id
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
end
