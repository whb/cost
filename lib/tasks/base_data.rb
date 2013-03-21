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

desc "Create the major categories"
task :default_major_categories => :environment do
  @m_1  = create :major_category, code: '01', name: '办公费'
  @m_2  = create :major_category, code: '02', name: '业务招待费'
  @m_3  = create :major_category, code: '03', name: '日常性费用'
  @m_4  = create :major_category, code: '04', name: '保险费'
  @m_5  = create :major_category, code: '05', name: '车辆费用'
  @m_6  = create :major_category, code: '06', name: '修理费'
  @m_7  = create :major_category, code: '07', name: '费用性税金'
  @m_8  = create :major_category, code: '08', name: '折旧费'
  @m_9  = create :major_category, code: '09', name: '聘请中介费'
  @m_10 = create :major_category, code: '10', name: '环境保护费'
  @m_11 = create :major_category, code: '11', name: '安全防范费'
  @m_12 = create :major_category, code: '12', name: '水电费'
  @m_13 = create :major_category, code: '13', name: '供暖燃料费（办公场所）'
end

desc "Create the default categories"
task :default_categories => :environment do
  @c_001  = create :category, code: '0101', name: '书报资料费', major_category: @m_1
  @c_002  = create :category, code: '0102', name: '办公用品费', major_category: @m_1
  @c_003  = create :category, code: '0103', name: '邮电费', major_category: @m_1
  @c_004  = create :category, code: '0104', name: '印刷费', major_category: @m_1
  @c_005  = create :category, code: '0105', name: '软件服务费', major_category: @m_1
  @c_006  = create :category, code: '0106', name: '电话费', major_category: @m_1
  @c_007  = create :category, code: '0107', name: '其他', major_category: @m_1

  @c_008  = create :category, code: '0201', name: '业务餐费', major_category: @m_2
  @c_009  = create :category, code: '0202', name: '礼品及其他', major_category: @m_2

  @c_010  = create :category, code: '0301', name: '会议费', major_category: @m_3
  @c_011  = create :category, code: '0302', name: '差旅费', major_category: @m_3
  @c_012  = create :category, code: '0303', name: '排污费', major_category: @m_3
  @c_013  = create :category, code: '0304', name: '供暖费（办公场所）', major_category: @m_3
  @c_014  = create :category, code: '0305', name: '燃料费', major_category: @m_3
  @c_015  = create :category, code: '0306', name: '宣传经费', major_category: @m_3
  @c_016  = create :category, code: '0307', name: '党委宣传费', major_category: @m_3
  @c_017  = create :category, code: '0308', name: '董事会会费', major_category: @m_3
  @c_018  = create :category, code: '0309', name: '协会会费', major_category: @m_3
  @c_019  = create :category, code: '0310', name: '出国人员费用', major_category: @m_3
  @c_020  = create :category, code: '0311', name: '直接材料费', major_category: @m_3
  @c_021  = create :category, code: '0312', name: '制造费用', major_category: @m_3
  @c_022  = create :category, code: '0313', name: '其他日常性费用', major_category: @m_3

  @c_023  = create :category, code: '0401', name: '财产保险费', major_category: @m_4
  @c_024  = create :category, code: '0402', name: '车辆保险费', major_category: @m_4
  @c_025  = create :category, code: '0403', name: '其他保险费', major_category: @m_4

  @c_026  = create :category, code: '0501', name: '燃油费-汽油', major_category: @m_5
  @c_027  = create :category, code: '0502', name: '燃油费-柴油', major_category: @m_5
  @c_028  = create :category, code: '0503', name: '燃油费-尿素', major_category: @m_5
  @c_029  = create :category, code: '0504', name: '燃油费-其他（外购）', major_category: @m_5
  @c_030  = create :category, code: '0505', name: '轮胎', major_category: @m_
  @c_031  = create :category, code: '0506', name: '车辆修理费', major_category: @m_5
  @c_032  = create :category, code: '0507', name: '停车过桥费', major_category: @m_5
  @c_033  = create :category, code: '0508', name: '车辆年检', major_category: @m_5
  @c_034  = create :category, code: '0509', name: '事故费', major_category: @m_
  @c_035  = create :category, code: '0510', name: '车上设备', major_category: @m_5
  @c_036  = create :category, code: '0511', name: '其他费用', major_category: @m_5

  @c_037  = create :category, code: '0601', name: '房屋维修费', major_category: @m_6
  @c_038  = create :category, code: '0602', name: '项目维修费（中修费）', major_category: @m_6
  @c_039  = create :category, code: '0603', name: '维保费用', major_category: @m_6
  @c_040  = create :category, code: '0604', name: '年检费用', major_category: @m_6
  @c_041  = create :category, code: '0605', name: '维修材料费', major_category: @m_6
  @c_042  = create :category, code: '0606', name: '专业设备维修费', major_category: @m_6
  @c_043  = create :category, code: '0607', name: '消防设施费', major_category: @m_6
  @c_044  = create :category, code: '0608', name: '监控设施费', major_category: @m_6
  @c_045  = create :category, code: '0609', name: '防汛器材费', major_category: @m_6
  @c_046  = create :category, code: '0610', name: '其他修理费', major_category: @m_6

  @c_047  = create :category, code: '0701', name: '车船使用税', major_category: @m_7
  @c_048  = create :category, code: '0702', name: '印花税', major_category: @m_7
  @c_049  = create :category, code: '0703', name: '房产税', major_category: @m_7
  @c_050  = create :category, code: '0704', name: '土地使用税', major_category: @m_7
  @c_051  = create :category, code: '0705', name: '价格调整基金', major_category: @m_7
  @c_052  = create :category, code: '0706', name: '防洪基金', major_category: @m_7
  @c_053  = create :category, code: '0707', name: '水利建设基金', major_category: @m_7
  @c_054  = create :category, code: '0708', name: '残疾人保障金', major_category: @m_7
  @c_055  = create :category, code: '0709', name: '土地使用费', major_category: @m_7
  @c_056  = create :category, code: '0710', name: '其他费用性税金', major_category: @m_7

  @c_057  = create :category, code: '0801', name: '房屋建筑物', major_category: @m_8
  @c_058  = create :category, code: '0802', name: '机器设备', major_category: @m_8
  @c_059  = create :category, code: '0803', name: '运输设备', major_category: @m_8
  @c_060  = create :category, code: '0804', name: '电子设备', major_category: @m_8
  @c_061  = create :category, code: '0805', name: '办公设备', major_category: @m_8
  @c_062  = create :category, code: '0806', name: '其他折旧费', major_category: @m_8

  @c_063  = create :category, code: '0901', name: '审计费', major_category: @m_9
  @c_064  = create :category, code: '0902', name: '诉讼费', major_category: @m_9
  @c_065  = create :category, code: '0903', name: '评估费', major_category: @m_9
  @c_066  = create :category, code: '0904', name: '咨询费', major_category: @m_9
  @c_067  = create :category, code: '0905', name: '网络服务费', major_category: @m_9
  @c_068  = create :category, code: '0906', name: '其他中介费', major_category: @m_9

  @c_069  = create :category, code: '1001', name: '绿化费', major_category: @m_10
  @c_070  = create :category, code: '1002', name: '清洁卫生费', major_category: @m_10
  @c_071  = create :category, code: '1003', name: '垃圾清运费', major_category: @m_10
  @c_072  = create :category, code: '1004', name: '污井清掏费', major_category: @m_10
  @c_073  = create :category, code: '1005', name: '管道疏通费', major_category: @m_10
  @c_074  = create :category, code: '1006', name: '保洁材料费', major_category: @m_10
  @c_075  = create :category, code: '1007', name: '其他环境保护费', major_category: @m_10

  @c_076  = create :category, code: '1101', name: '消防费', major_category: @m_11
  @c_077  = create :category, code: '1102', name: '安保费', major_category: @m_11
  @c_078  = create :category, code: '1103', name: '其他安保费', major_category: @m_11

  @c_079  = create :category, code: '1201', name: '水费', major_category: @m_12
  @c_080  = create :category, code: '1202', name: '电费', major_category: @m_12

  @c_081  = create :category, code: '1301', name: '燃气费用', major_category: @m_13
  @c_082  = create :category, code: '1302', name: '燃油费用', major_category: @m_13
  @c_083  = create :category, code: '1303', name: '制冷及热水费', major_category: @m_13
  @c_084  = create :category, code: '1304', name: '其他燃料费', major_category: @m_13
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