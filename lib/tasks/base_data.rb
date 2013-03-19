#encoding:utf-8

desc "Add the admin user"
task :admin_user => :environment do
  create :user, username: 'admin', displayname: '<管理员>', password: 'xldirdos307', password_confirmation: 'xldirdos307',
                roles: %w[admin], organization_id: 0
end

desc "Create the scaffold organizations"
task :scaffold_organizations => :environment do
  @xllg      = create :organization, code: '001', name: '《祥龙物流》'
  @lingdao   = create :organization, code: '002', name: '[领导办公室]', superior: @xllg
end

desc "Create the manager users"
task :manager_users => :environment do
  @ma   = create :user, username: 'maxin', displayname: '马昕', roles: %w[general_manager], organization: @lingdao
  @sun  = create :user, username: 'sunbaoxi', displayname: '孙宝熙', roles: %w[vice_manager], organization: @lingdao 
  @li  = create :user, username: 'liwei', displayname: '李卫', roles: %w[vice_manager], organization: @lingdao 
  @zhao  = create :user, username: 'zhaodagang', displayname: '赵大刚', roles: %w[vice_manager], organization: @lingdao  
  @wang  = create :user, username: 'wangguogang', displayname: '王国刚', roles: %w[vice_manager], organization: @lingdao 
  @han  = create :user, username: 'hanchangsheng', displayname: '韩长生', roles: %w[vice_manager], organization: @lingdao 
  @shen  = create :user, username: 'shenzhimei', displayname: '沈智梅', roles: %w[vice_manager], organization: @lingdao 
end

desc "Create the default organizations"
task :default_organizations => :environment do
  @xingzheng = create :organization, code: '003', name: '总经理办公室', kind: 'department', superior: @xllg, upper_manager: @ma
  @caiwu     = create :organization, code: '004', name: '财务部', kind: 'department', superior: @xllg, upper_manager: @ma
  @shenji    = create :organization, code: '005', name: '审计部', kind: 'department', superior: @xllg, upper_manager: @ma
  @anbao     = create :organization, code: '006', name: '安全保卫部', kind: 'department', superior: @xllg, upper_manager: @sun
  @renli     = create :organization, code: '007', name: '人力资源部', kind: 'department', superior: @xllg, upper_manager: @sun
  @shichang  = create :organization, code: '008', name: '市场发展部', kind: 'department', superior: @xllg, upper_manager: @li
  @yunshu    = create :organization, code: '009', name: '运输部', kind: 'department', superior: @xllg, upper_manager: @zhao
  @zichan    = create :organization, code: '010', name: '资产设备部', kind: 'department', superior: @xllg, upper_manager: @wang
  @qiguan    = create :organization, code: '011', name: '企管部', kind: 'department', superior: @xllg, upper_manager: @han
  @xinxi     = create :organization, code: '012', name: '信息部', kind: 'department', superior: @xllg, upper_manager: @han
  @dangwei   = create :organization, code: '013', name: '党委工作部', kind: 'department', superior: @xllg, upper_manager: @shen
  @gonghui   = create :organization, code: '014', name: '工会', kind: 'department', superior: @xllg, upper_manager: @shen
  @jiwei     = create :organization, code: '015', name: '纪委', kind: 'department', superior: @xllg, upper_manager: @shen
end

desc "Create the default users"
task :default_users => :environment do
  @song  = create :user, username: 'songyue', displayname: '宋悦', roles: %w[financial_officer staff department_manager], organization: @caiwu
  @wu    = create :user, username: 'wujiyou', displayname: '吴继友', roles: %w[staff department_manager], organization: @qiguan
  @whb   = create :user, username: 'wuhaibo', displayname: '吴海波', roles: %w[staff department_manager], organization: @xinxi
  @guo   = create :user, username: 'guowenjing', displayname: '郭文静', roles: %w[admin staff], organization: @xinxi
  @zhang = create :user, username: 'zhangjunyi', displayname: '张君毅', roles: %w[staff], organization: @xinxi
  @mao   = create :user, username: 'maoyating', displayname: '毛雅婷', roles: %w[staff], organization: @qiguan
  @cai   = create :user, username: 'caijuan', displayname: '才娟', roles: %w[staff department_manager], organization: @gonghui
  @qi    = create :user, username: 'qiqinggang', displayname: '齐庆刚', roles: %w[staff department_manager], organization: @jiwei
  @liu   = create :user, username: 'liuchunyu', displayname: '刘春雨', roles: %w[staff], organization: @shenji
  @meng  = create :user, username: 'mengsuwen', displayname: '孟素文', roles: %w[staff department_manager], organization: @shenji
  @yang  = create :user, username: 'yangdan', displayname: '杨丹', roles: %w[staff], organization: @caiwu
  @liang = create :user, username: 'liangxiujun', displayname: '梁秀军', roles: %w[staff], organization: @caiwu
  @gao   = create :user, username: 'gaozongying', displayname: '高宗英', roles: %w[staff department_manager], organization: @dangwei
  @sui   = create :user, username: 'suihaiyan', displayname: '隋海燕', roles: %w[staff], organization: @dangwei
  @ding  = create :user, username: 'dinghuakun', displayname: '丁华坤', roles: %w[staff], organization: @dangwei
  @yangj = create :user, username: 'yangjun', displayname: '杨军', roles: %w[staff], organization: @yunshu
  @wangy = create :user, username: 'wangyubao', displayname: '王玉保', roles: %w[staff department_manager], organization: @yunshu
  @zhangy= create :user, username: 'zhangruixue', displayname: '张瑞雪', roles: %w[staff], organization: @shichang
  @wangq = create :user, username: 'wangqing', displayname: '王清', roles: %w[staff department_manager], organization: @shichang
  @cai   = create :user, username: 'caiyali', displayname: '蔡雅丽', roles: %w[staff], organization: @renli
  @tang  = create :user, username: 'tanglinlin', displayname: '汤琳琳', roles: %w[staff], organization: @renli
  @wangk = create :user, username: 'wangke', displayname: '王珂', roles: %w[staff department_manager], organization: @renli
  @he    = create :user, username: 'heyuanjiang', displayname: '何原江', roles: %w[staff], organization: @anbao
  @liuj  = create :user, username: 'liujinsheng', displayname: '刘金生', roles: %w[staff department_manager], organization: @anbao
  @bai   = create :user, username: 'baixiangdong', displayname: '白向东', roles: %w[staff], organization: @zichan
  @chen  = create :user, username: 'chenzhenyuan', displayname: '陈振元', roles: %w[staff department_manager], organization: @zichan
  @ji    = create :user, username: 'jiqingmei', displayname: '季青梅', roles: %w[staff], organization: @xingzheng
  @zhaop = create :user, username: 'zhaopuyun', displayname: '赵谱云', roles: %w[staff department_manager], organization: @xingzheng
end

desc "Create the major categories"
task :default_major_categories => :environment do
  @m_1  = create :major_category, code: '01', name: '办公费用'
  @m_2  = create :major_category, code: '02', name: '其它费用'
end

desc "Create the default categories"
task :default_categories => :environment do
  @c_1  = create :category, code: '0101', name: '办公家具', major_category: @m_1
  @c_2  = create :category, code: '0102', name: '办公设备', major_category: @m_1
  @c_3  = create :category, code: '0103', name: '办公耗材', major_category: @m_1
  @c_4  = create :category, code: '0201', name: '差旅费', major_category: @m_2
  @c_5  = create :category, code: '0202', name: '会务费', major_category: @m_2
  @c_6  = create :category, code: '0301', name: '慰问费(行政)', major_category: @m_2
  @c_7  = create :category, code: '0302', name: '慰问费(政工)', major_category: @m_2
  @c_8  = create :category, code: '0401', name: '计算机设备', major_category: @m_2
  @c_9  = create :category, code: '0402', name: '网络设备', major_category: @m_2
  @c_10 = create :category, code: '0403', name: '计算机维修费', major_category: @m_2
  @c_11 = create :category, code: '0501', name: '软件开发费', major_category: @m_2
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
  create :user,  username: 'test', displayname: '测试用户', password: 'a',
                 roles: %w[admin staff department_manager vice_manager financial_officer], 
                 organization: @xllg
end

desc "Run base tasks"
task :base => [ :admin_user, 
                :scaffold_organizations, :manager_users, :default_organizations, :default_users, 
                :default_major_categories, :default_categories, :default_periods, :default_budgets, 
                :test_users]