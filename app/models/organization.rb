#encoding:utf-8

class Organization < ActiveRecord::Base
  has_many :subordinates, :class_name => "Organization", :foreign_key => "superior_id"
  belongs_to :superior, :class_name => "Organization"
  has_many :users
  attr_accessible :code, :name, :superior_id, :kind
  validates_uniqueness_of :code, :name
  validates_presence_of :code, :name

  KIND_TYPES = {
    :department => "部门",
  }
  enum :kind, KIND_TYPES

  def self.default
    Organization.find(1)
  end

  def self.nil_object
    Organization.new
  end

  def subtree_ids
    org_ids = []
    org_ids << self.id
    subs = self.subordinates
    if subs
      subs.each do |o|
        org_ids << o.subtree_ids
      end
    end
    org_ids
  end

  def self_sons_ids
    org_ids = []
    org_ids << self.id
    subs = self.subordinates
    if subs
      subs.each do |o|
        org_ids << o.id
      end
    end
    org_ids
  end
end
