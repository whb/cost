#encoding:utf-8

desc "Add the admin user"
task :admin_user => :environment do
  create :user, username: 'admin', displayname: '<管理员>', password: 'xldirdos307', password_confirmation: 'xldirdos307',
                roles: %w[admin], organization_id: 0
end

desc "Create the default organizations"
task :default_organizations => :environment do
  @xllg      = create :organization, code: '001', name: '《祥龙物流》'
  @anren     = create :organization, code: '002', name: '[安保人力]', superior: @xllg
  @qixin     = create :organization, code: '003', name: '[企管信息]', superior: @xllg
  @danggong  = create :organization, code: '004', name: '[党委工会]', superior: @xllg
  @xingzheng = create :organization, code: '005', name: '行政办公室', kind: 'department', superior: @xllg
  @caiwu     = create :organization, code: '006', name: '财务部', kind: 'department', superior: @xllg
  @shenji    = create :organization, code: '007', name: '审计部', kind: 'department', superior: @xllg
  @anbao     = create :organization, code: '008', name: '安保部', kind: 'department', superior: @anren
  @renli     = create :organization, code: '009', name: '人力资源部', kind: 'department', superior: @anren
  @shichang  = create :organization, code: '010', name: '市场部', kind: 'department', superior: @xllg
  @yunshu    = create :organization, code: '011', name: '运输部', kind: 'department', superior: @xllg
  @zichan    = create :organization, code: '012', name: '资产设备部', kind: 'department', superior: @xllg
  @qiguan    = create :organization, code: '013', name: '企管部', kind: 'department', superior: @qixin
  @xinxi     = create :organization, code: '014', name: '信息部', kind: 'department', superior: @qixin
  @dangwei   = create :organization, code: '015', name: '党委工作部', kind: 'department', superior: @danggong
  @gonghui   = create :organization, code: '016', name: '工会', kind: 'department', superior: @danggong
end

desc "Create the default users"
task :default_users => :environment do
  @ma   = create :user, username: 'ma', displayname: '马昕', roles: %w[general_manager], organization: @xllg
  @han  = create :user, username: 'han', displayname: '韩长生', roles: %w[vice_manager], organization: @qixin 
  @song = create :user, username: 'song', displayname: '宋悦', roles: %w[financial_officer], organization: @caiwu
  @wu   = create :user, username: 'wu', displayname: '吴继友', roles: %w[staff department_manager], organization: @qiguan
  @whb  = create :user, username: 'whb', displayname: '吴海波', roles: %w[staff department_manager], organization: @xinxi
  @guo  = create :user, username: 'guo', displayname: '郭文静', roles: %w[admin staff], organization: @xinxi
end

desc "Create the default categories"
task :default_categories => :environment do
  @c_1  = create :category, code: '0101', name: '办公家具'
  @c_2  = create :category, code: '0102', name: '办公设备'
  @c_3  = create :category, code: '0103', name: '办公耗材'
  @c_4  = create :category, code: '0201', name: '差旅费'
  @c_5  = create :category, code: '0202', name: '会务费'
  @c_6  = create :category, code: '0301', name: '慰问费(行政)'
  @c_7  = create :category, code: '0302', name: '慰问费(政工)'
  @c_8  = create :category, code: '0401', name: '计算机设备'
  @c_9  = create :category, code: '0402', name: '网络设备'
  @c_10 = create :category, code: '0403', name: '计算机维修费'
  @c_11 = create :category, code: '0501', name: '软件开发费'
end

desc "Create the default periods"
task :default_periods => :environment do
  @p_2013 = create :period, year: 2013, explain: '2013年度预算'
end

desc "Create the default budget"
task :default_budgets => :environment do
  create :budget, period: @p_2013, category: @c_1, amount: 100000
  create :budget, period: @p_2013, category: @c_2, amount: 100000
  create :budget, period: @p_2013, category: @c_3, amount: 100000
  create :budget, period: @p_2013, category: @c_4, amount: 100000
  create :budget, period: @p_2013, category: @c_5, amount: 100000
  create :budget, period: @p_2013, category: @c_6, amount: 100000
  create :budget, period: @p_2013, category: @c_7, amount: 100000
  create :budget, period: @p_2013, category: @c_8, amount: 100000
  create :budget, period: @p_2013, category: @c_9, amount: 100000
  create :budget, period: @p_2013, category: @c_10, amount: 50000
  create :budget, period: @p_2013, category: @c_11
end

desc "Create the test users"
task :test_users => :environment do
  create :user,  username: 'test', displayname: '测试用户', 
                 roles: %w[admin staff department_manager vice_manager financial_officer], 
                 organization: @xllg
end

desc "Run base tasks"
task :base => [ :admin_user, 
                :default_organizations, :default_users, :default_categories, :default_periods, :default_budgets, 
                :test_users]