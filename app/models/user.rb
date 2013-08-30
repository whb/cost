  require 'net/ldap'

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


  def after_initialize
    @config = YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result)[Rails.env]
  end

  def ldap_auth(user, pass)
    @config = YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result)[Rails.env]

    ldap = initialize_ldap_con
    result = ldap.bind_as(
      :base => @config['base_dn'],
      :filter => "(#{@config['attributes']['uid']}=#{user})",
      :password => pass
    )
    if result
      # fetch user DN
      get_user_dn user
      # sync_ldap_with_db user
    end
    nil
  end

  private
  def initialize_ldap_con
    options = { :host => @config['host'],
                :port => @config['port'],
                :encryption => (@config['tls'] ? :simple_tls : nil),
                :auth => { 
                  :method => :simple,
                  :username => @config['ldap_user'],
                  :password => @config['ldap_password']
                }
              }
    Net::LDAP.new options
  end

  def get_user_dn(user)
    ldap = initialize_ldap_con
    login_filter = Net::LDAP::Filter.eq @config['attributes']['uid'], "#{user}"
    object_filter = Net::LDAP::Filter.eq "objectClass", "*" 

    ldap.search :base => @config['base_dn'],
                :filter => object_filter & login_filter,
                :attributes => ['dn', @config['attributes']['first_name'], @config['attributes']['last_name'], @config['attributes']['mail']] do |entry|
      logger.debug "DN: #{entry.dn}"
      entry.each do |attr, values|
        values.each do |value|
          logger.debug "#{attr} = #{value}"
        end
      end
    end
  end
end
