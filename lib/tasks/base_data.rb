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
  @li   = create :user, username: 'liwei', displayname: '李卫', roles: %w[vice_manager], organization: @lingdao 
  @zhao = create :user, username: 'zhaodagang', displayname: '赵大刚', roles: %w[vice_manager], organization: @lingdao  
  @wang = create :user, username: 'wangguogang', displayname: '王国刚', roles: %w[vice_manager], organization: @lingdao 
  @han  = create :user, username: 'hanchangsheng', displayname: '韩长生', roles: %w[vice_manager], organization: @lingdao 
  @shen = create :user, username: 'shenzhimei', displayname: '沈智梅', roles: %w[vice_manager], organization: @lingdao 
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

desc "Create the default categories"
task :default_categories => :environment do
  @c_1     = create :category, code: '1', name: '日常费用'
  @c_2     = create :category, code: '2', name: '福利费用'
  @c_3     = create :category, code: '3', name: '离退休人员统筹外费用'
  
  @c_101   = create :category, code: '101', name: '职工教育经费', superior: @c_1
  
  @c_102   = create :category, code: '102', name: '劳动保护费', superior: @c_1
  @c_10201 = create :category, code: '10201', name: '劳保用品', superior: @c_102
  @c_10202 = create :category, code: '10202', name: '工作服', superior: @c_102
  @c_10203 = create :category, code: '10203', name: '防暑降温费用', superior: @c_102
  @c_10204 = create :category, code: '10204', name: '劳保费其他', superior: @c_102
  
  @c_105   = create :category, code: '105', name: '公务车费用', superior: @c_1
  @c_10501 = create :category, code: '10501', name: '燃料费', superior: @c_105
  @c_10502 = create :category, code: '10502', name: '修理费', superior: @c_105
  @c_10503 = create :category, code: '10503', name: '停车过桥费', superior: @c_105
  
  @c_117   = create :category, code: '117', name: '残疾人保证金', superior: @c_1

  @c_201   = create :category, code: '201', name: '独生子女费用', superior: @c_2
  @c_301   = create :category, code: '301', name: '离退休人员医保', superior: @c_3
end

desc "Create the default periods"
task :default_periods => :environment do
  @p_2013 = create :period, year: 2013, explain: '2013年度预算'
end

desc "Create the default budget"
task :default_budgets => :environment do
  create :budget, period: @p_2013, category: @c_101, amount: 200000
  create :budget, period: @p_2013, category: @c_102, amount: 140000
  create :budget, period: @p_2013, category: @c_10501, amount: 100000
  create :budget, period: @p_2013, category: @c_10502, amount: 100000
  create :budget, period: @p_2013, category: @c_10503, amount: 100000
  create :budget, period: @p_2013, category: @c_117
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
                :default_categories, :default_periods, :default_budgets, 
                :test_users]