class Category < ActiveRecord::Base
  has_many :subordinates, :class_name => "Category", :foreign_key => "superior_id"
  belongs_to :superior, :class_name => "Category"
  has_many :budgets

  attr_accessible :code, :name, :superior_id
  validates_presence_of :code, :name
  validates_uniqueness_of :code

  default_scope :order => :code

  after_save :clear_class_cache
  after_destroy :clear_class_cache

  def clear_class_cache
    @@father = nil
    # can be more efficiency
    @@branch_leaves = nil
  end

  def code_name
    code + name
  end

  def level
    return 1 if code.length == 1
    return 2 if code.length == 3
    return 3 if code.length == 5
  end

  def self.father
    @@father ||= find_father
  end

  def self.find_father
    f = []
    Category.order(:code).each do |c|
      f << c unless c.leaves.empty?
    end
    f
  end

  def leaves
    @leaves ||= find_leaves
  end

  def find_leaves
    l = []
    self.subordinates.each do |c|
      l << c if c.subordinates.empty?
    end
    l
  end

  def child_leaf_ids
    child_leaves.map {|c| c.id}
  end

  def child_leaves
    @@branch_leaves ||= {}
    return @@branch_leaves[self.id] if @@branch_leaves[self.id]
    @@branch_leaves[self.id] = find_child_leaves
  end

  def find_child_leaves
    child_categories = []
    subs = self.subordinates
    if subs.empty?
      child_categories << self
    else
      subs.each do |c|
        child_categories << c.find_child_leaves
      end
    end
    child_categories.flatten
  end

  def branch_node?
    @branch_node ||= !self.subordinates.empty?
  end

  def id_for_cost
    self.branch_node? ? self.child_leaf_ids : self.id
  end

  def equals_or_has_child(category)
    return true if self == category
    self.child_leaves.include? category
  end

  def self.branch_nodes
    nodes = []
    Category.all.each do | c |
      if c.branch_node?
        nodes << c
      end
    end
    nodes
  end

  def self.leaf_nodes
    nodes = []
    Category.all.each do | c |
      unless c.branch_node?
        nodes << c
      end
    end
    nodes
  end

end
