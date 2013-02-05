class User < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :displayname, :enabled, :organization_id, :username, :password, :password_confirmation

  has_secure_password
  validates_presence_of :username, :displayname, :organization_id
end
