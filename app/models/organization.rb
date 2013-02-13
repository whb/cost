class Organization < ActiveRecord::Base
  has_many :subordinates, :class_name => "Organization", :foreign_key => "superior_id"
  belongs_to :superior, :class_name => "Organization"
  has_many :users
  attr_accessible :code, :name, :superior_id

  def self.default
    Organization.find(1)
  end
end
