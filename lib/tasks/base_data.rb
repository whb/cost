#encoding:utf-8

desc "Add the admin user"
task :admin_user => :environment do
  create :user, username:'admin', displayname:'<管理员>', password:'xldirdos307', password_confirmation:'xldirdos307',
                roles: %w[admin], organization_id: 0
end

desc "Create the scaffold organizations"
task :scaffold_organizations => :environment do
  @xllg      = create :organization, code:'001', name:'《祥龙物流》'
  @lingdao   = create :organization, code:'002', name:'[领导办公室]', superior: @xllg
end

desc "Create the manager users"
task :manager_users => :environment do
  @ma   = create :user, username:'maxin', displayname:'马昕', roles: %w[general_manager], organization: @lingdao
  @sun  = create :user, username:'sunbaoxi', displayname:'孙宝熙', roles: %w[vice_manager], organization: @lingdao 
  @li   = create :user, username:'liwei', displayname:'李卫', roles: %w[vice_manager], organization: @lingdao 
  @zhao = create :user, username:'zhaodagang', displayname:'赵大刚', roles: %w[vice_manager], organization: @lingdao  
  @wang = create :user, username:'wangguogang', displayname:'王国刚', roles: %w[vice_manager], organization: @lingdao 
  @han  = create :user, username:'hanchangsheng', displayname:'韩长生', roles: %w[vice_manager], organization: @lingdao 
  @shen = create :user, username:'shenzhimei', displayname:'沈智梅', roles: %w[vice_manager], organization: @lingdao 
end

desc "Create the default organizations"
task :default_organizations => :environment do
  @xingzheng = create :organization, code:'003', name:'总经理办公室', kind:'department', superior: @xllg, upper_manager: @ma
  @caiwu     = create :organization, code:'004', name:'财务部', kind:'department', superior: @xllg, upper_manager: @ma
  @shenji    = create :organization, code:'005', name:'审计部', kind:'department', superior: @xllg, upper_manager: @ma
  @anbao     = create :organization, code:'006', name:'安全保卫部', kind:'department', superior: @xllg, upper_manager: @sun
  @renli     = create :organization, code:'007', name:'人力资源部', kind:'department', superior: @xllg, upper_manager: @sun
  @shichang  = create :organization, code:'008', name:'市场发展部', kind:'department', superior: @xllg, upper_manager: @li
  @yunshu    = create :organization, code:'009', name:'运输部', kind:'department', superior: @xllg, upper_manager: @zhao
  @zichan    = create :organization, code:'010', name:'资产设备部', kind:'department', superior: @xllg, upper_manager: @wang
  @qiguan    = create :organization, code:'011', name:'企管部', kind:'department', superior: @xllg, upper_manager: @han
  @xinxi     = create :organization, code:'012', name:'信息部', kind:'department', superior: @xllg, upper_manager: @han
  @dangwei   = create :organization, code:'013', name:'党委工作部', kind:'department', superior: @xllg, upper_manager: @shen
  @gonghui   = create :organization, code:'014', name:'工会', kind:'department', superior: @xllg, upper_manager: @shen
  @jiwei     = create :organization, code:'015', name:'纪委', kind:'department', superior: @xllg, upper_manager: @shen
end

desc "Create the default users"
task :default_users => :environment do
  @song  = create :user, username:'songyue', displayname:'宋悦', roles: %w[financial_officer staff department_manager], organization: @caiwu
  @wu    = create :user, username:'wujiyou', displayname:'吴继友', roles: %w[staff department_manager], organization: @qiguan
  @whb   = create :user, username:'wuhaibo', displayname:'吴海波', roles: %w[staff department_manager], organization: @xinxi
  @guo   = create :user, username:'guowenjing', displayname:'郭文静', roles: %w[admin staff], organization: @xinxi
  @zhang = create :user, username:'zhangjunyi', displayname:'张君毅', roles: %w[staff], organization: @xinxi
  @mao   = create :user, username:'maoyating', displayname:'毛雅婷', roles: %w[staff], organization: @qiguan
  @cai   = create :user, username:'caijuan', displayname:'才娟', roles: %w[staff department_manager], organization: @gonghui
  @qi    = create :user, username:'qiqinggang', displayname:'齐庆刚', roles: %w[staff department_manager], organization: @jiwei
  @liu   = create :user, username:'liuchunyu', displayname:'刘春雨', roles: %w[staff], organization: @shenji
  @meng  = create :user, username:'mengsuwen', displayname:'孟素文', roles: %w[staff department_manager], organization: @shenji
  @yang  = create :user, username:'yangdan', displayname:'杨丹', roles: %w[staff], organization: @caiwu
  @liang = create :user, username:'liangxiujun', displayname:'梁秀军', roles: %w[staff], organization: @caiwu
  @gao   = create :user, username:'gaozongying', displayname:'高宗英', roles: %w[staff department_manager], organization: @dangwei
  @sui   = create :user, username:'suihaiyan', displayname:'隋海燕', roles: %w[staff], organization: @dangwei
  @ding  = create :user, username:'dinghuakun', displayname:'丁华坤', roles: %w[staff], organization: @dangwei
  @yangj = create :user, username:'yangjun', displayname:'杨军', roles: %w[staff], organization: @yunshu
  @wangy = create :user, username:'wangyubao', displayname:'王玉保', roles: %w[staff department_manager], organization: @yunshu
  @zhangy= create :user, username:'zhangruixue', displayname:'张瑞雪', roles: %w[staff], organization: @shichang
  @wangq = create :user, username:'wangqing', displayname:'王清', roles: %w[staff department_manager], organization: @shichang
  @cai   = create :user, username:'caiyali', displayname:'蔡雅丽', roles: %w[staff], organization: @renli
  @tang  = create :user, username:'tanglinlin', displayname:'汤琳琳', roles: %w[staff], organization: @renli
  @wangk = create :user, username:'wangke', displayname:'王珂', roles: %w[staff department_manager], organization: @renli
  @he    = create :user, username:'heyuanjiang', displayname:'何原江', roles: %w[staff], organization: @anbao
  @liuj  = create :user, username:'liujinsheng', displayname:'刘金生', roles: %w[staff department_manager], organization: @anbao
  @bai   = create :user, username:'baixiangdong', displayname:'白向东', roles: %w[staff], organization: @zichan
  @chen  = create :user, username:'chenzhenyuan', displayname:'陈振元', roles: %w[staff department_manager], organization: @zichan
  @ji    = create :user, username:'jiqingmei', displayname:'季青梅', roles: %w[staff], organization: @xingzheng
  @zhaop = create :user, username:'zhaopuyun', displayname:'赵谱云', roles: %w[staff department_manager], organization: @xingzheng
end

desc "Create the default categories"
task :default_categories => :environment do
  @c_1  = create :category, code:'1', name:'日常费用支出'
  @c_2  = create :category, code:'2', name:'福利费用支出'
  @c_3  = create :category, code:'3', name:'离退休人员统筹外费用'
  @c_4  = create :category, code:'4', name:'资产投资支出'
  @c_5  = create :category, code:'5', name:'运输项目支出'
  @c_6  = create :category, code:'6', name:'专项储备'

  @c_101 = create :category, code:'101', name:'职工教育经费', superior: @c_1
  @c_102 = create :category, code:'102', name:'劳动保护费', superior: @c_1
  @c_103 = create :category, code:'103', name:'广告宣传费', superior: @c_1
  @c_104 = create :category, code:'104', name:'办公费', superior: @c_1
  @c_105 = create :category, code:'105', name:'公务车费用', superior: @c_1
  @c_106 = create :category, code:'106', name:'差旅费', superior: @c_1
  @c_107 = create :category, code:'107', name:'修理费', superior: @c_1
  @c_108 = create :category, code:'108', name:'业务招待费', superior: @c_1
  @c_109 = create :category, code:'109', name:'水电费', superior: @c_1
  @c_110 = create :category, code:'110', name:'供暖费', superior: @c_1
  @c_111 = create :category, code:'111', name:'会务费', superior: @c_1
  @c_112 = create :category, code:'112', name:'安全费用', superior: @c_1
  @c_113 = create :category, code:'113', name:'劳务费', superior: @c_1
  @c_114 = create :category, code:'114', name:'租赁费', superior: @c_1
  @c_115 = create :category, code:'115', name:'聘请中介费', superior: @c_1
  @c_116 = create :category, code:'116', name:'保险费', superior: @c_1
  @c_117 = create :category, code:'117', name:'残疾人保证金', superior: @c_1
  @c_118 = create :category, code:'118', name:'其他', superior: @c_1
  @c_201 = create :category, code:'201', name:'独生子女费用', superior: @c_2
  @c_202 = create :category, code:'202', name:'职工供暖费', superior: @c_2
  @c_203 = create :category, code:'203', name:'职工困难补助', superior: @c_2
  @c_204 = create :category, code:'204', name:'职工食堂补助', superior: @c_2
  @c_205 = create :category, code:'205', name:'职工体检费', superior: @c_2
  @c_206 = create :category, code:'206', name:'职工防暑降温费', superior: @c_2
  @c_207 = create :category, code:'207', name:'慰问费', superior: @c_2
  @c_208 = create :category, code:'208', name:'职工丧葬费抚恤金', superior: @c_2
  @c_209 = create :category, code:'209', name:'福利费其他', superior: @c_2
  @c_301 = create :category, code:'301', name:'离退休人员医保', superior: @c_3
  @c_302 = create :category, code:'302', name:'离退休人员福利费', superior: @c_3
  @c_303 = create :category, code:'303', name:'离退休人员经费', superior: @c_3
  @c_304 = create :category, code:'304', name:'离退休人员补助', superior: @c_3
  @c_401 = create :category, code:'401', name:'购置固定资产', superior: @c_4
  @c_402 = create :category, code:'402', name:'工程项目支出', superior: @c_4
  @c_403 = create :category, code:'403', name:'无形资产支出', superior: @c_4
  @c_501 = create :category, code:'501', name:'验路费', superior: @c_5
  @c_502 = create :category, code:'502', name:'协调费', superior: @c_5
  @c_503 = create :category, code:'503', name:'道路补偿金', superior: @c_5
  @c_504 = create :category, code:'504', name:'长途食宿费', superior: @c_5
  @c_505 = create :category, code:'505', name:'长途燃料费', superior: @c_5
  @c_506 = create :category, code:'506', name:'长途路桥费', superior: @c_5
  @c_507 = create :category, code:'507', name:'项目保险费', superior: @c_5
  @c_508 = create :category, code:'508', name:'外付运费', superior: @c_5
  @c_509 = create :category, code:'509', name:'运输项目差旅费', superior: @c_5
  @c_510 = create :category, code:'510', name:'运输项目费用其他', superior: @c_5
  @c_601 = create :category, code:'601', name:'费用性支出', superior: @c_6
  @c_602 = create :category, code:'602', name:'资本性支出', superior: @c_6

  @c_10201 = create :category, code:'10201', name:'劳保用品', superior: @c_102
  @c_10202 = create :category, code:'10202', name:'工作服', superior: @c_102
  @c_10203 = create :category, code:'10203', name:'劳保费其他', superior: @c_102
  @c_10301 = create :category, code:'10301', name:'工会宣传费', superior: @c_103
  @c_10302 = create :category, code:'10302', name:'党委宣传费', superior: @c_103
  @c_10303 = create :category, code:'10303', name:'广告制作费', superior: @c_103
  @c_10304 = create :category, code:'10304', name:'广告宣传费其他', superior: @c_103
  @c_10401 = create :category, code:'10401', name:'购办公用品', superior: @c_104
  @c_10402 = create :category, code:'10402', name:'书报资料费', superior: @c_104
  @c_10403 = create :category, code:'10403', name:'印刷费', superior: @c_104
  @c_10404 = create :category, code:'10404', name:'软件服务费', superior: @c_104
  @c_10405 = create :category, code:'10405', name:'电话费', superior: @c_104
  @c_10406 = create :category, code:'10406', name:'邮电费', superior: @c_104
  @c_10407 = create :category, code:'10407', name:'办公费其他', superior: @c_104
  @c_10501 = create :category, code:'10501', name:'燃料费', superior: @c_105
  @c_10502 = create :category, code:'10502', name:'修理费', superior: @c_105
  @c_10503 = create :category, code:'10503', name:'停车过桥费', superior: @c_105
  @c_10504 = create :category, code:'10504', name:'车上设备', superior: @c_105
  @c_10505 = create :category, code:'10505', name:'轮胎费用', superior: @c_105
  @c_10506 = create :category, code:'10506', name:'车辆年检费', superior: @c_105
  @c_10507 = create :category, code:'10507', name:'公务车费用其他', superior: @c_105
  @c_10701 = create :category, code:'10701', name:'房屋修理费', superior: @c_107
  @c_10702 = create :category, code:'10702', name:'设备维修费', superior: @c_107
  @c_10801 = create :category, code:'10801', name:'业务餐费', superior: @c_108
  @c_10802 = create :category, code:'10802', name:'礼品及其他', superior: @c_108
  @c_10901 = create :category, code:'10901', name:'水费', superior: @c_109
  @c_10902 = create :category, code:'10902', name:'电费', superior: @c_109
  @c_11101 = create :category, code:'11101', name:'会议费', superior: @c_111
  @c_11102 = create :category, code:'11102', name:'协会会费', superior: @c_111
  @c_11201 = create :category, code:'11201', name:'安全生产费', superior: @c_112
  @c_11202 = create :category, code:'11202', name:'消防费', superior: @c_112
  @c_11203 = create :category, code:'11203', name:'安保费', superior: @c_112
  @c_11204 = create :category, code:'11204', name:'事故费', superior: @c_112
  @c_11205 = create :category, code:'11205', name:'安全费用其他', superior: @c_112
  @c_11401 = create :category, code:'11401', name:'房屋租赁费', superior: @c_114
  @c_11402 = create :category, code:'11402', name:'设备租赁费', superior: @c_114
  @c_11501 = create :category, code:'11501', name:'审计费', superior: @c_115
  @c_11502 = create :category, code:'11502', name:'诉讼费', superior: @c_115
  @c_11503 = create :category, code:'11503', name:'咨询费', superior: @c_115
  @c_11504 = create :category, code:'11504', name:'评估费', superior: @c_115
  @c_11505 = create :category, code:'11505', name:'其他中介费', superior: @c_115
  @c_11601 = create :category, code:'11601', name:'财产保险费', superior: @c_116
  @c_11602 = create :category, code:'11602', name:'车辆保险费', superior: @c_116
  @c_11801 = create :category, code:'11801', name:'绿化费', superior: @c_118
  @c_11802 = create :category, code:'11802', name:'清洁卫生费', superior: @c_118
  @c_11803 = create :category, code:'11803', name:'垃圾清运费', superior: @c_118
  @c_11804 = create :category, code:'11804', name:'其他', superior: @c_118
  @c_60101 = create :category, code:'60101', name:'安全设施检测费', superior: @c_601
  @c_60102 = create :category, code:'60102', name:'应急器材保养维护费', superior: @c_601
  @c_60103 = create :category, code:'60103', name:'作业人员安全防护用品费', superior: @c_601
  @c_60104 = create :category, code:'60104', name:'安全生产宣传费', superior: @c_601
  @c_60105 = create :category, code:'60105', name:'特种设备检测检验费', superior: @c_601
  @c_60106 = create :category, code:'60106', name:'其他安全费用支出', superior: @c_601
  @c_60201 = create :category, code:'60201', name:'购置车辆导航设备', superior: @c_602
  @c_60202 = create :category, code:'60202', name:'配备应急救援器材', superior: @c_602
  @c_60203 = create :category, code:'60203', name:'其他资本性支出', superior: @c_602

  $leaf_categories = [@c_101, @c_106, 
    @c_201, @c_202, @c_203, @c_204, @c_205, @c_206, @c_207, @c_208, @c_209, 
    @c_301, @c_302, @c_303, @c_304, @c_401, @c_402, @c_403, @c_501, @c_502, 
    @c_503, @c_504, @c_505, @c_506, @c_507, @c_508, @c_509, @c_510, 
    @c_10201, @c_10202, @c_10203, @c_10301, @c_10302, @c_10303, 
    @c_10304, @c_10401, @c_10402, @c_10403, @c_10404, @c_10405, @c_10406, @c_10407, 
    @c_10501, @c_10502, @c_10503, @c_10504, @c_10505, @c_10506, @c_10507, @c_10701, @c_10702, 
    @c_10801, @c_10802, @c_10901, @c_10902, @c_11101, @c_11102, @c_11201, @c_11202, @c_11203, 
    @c_11204, @c_11205, @c_11401, @c_11402, @c_11501, @c_11502, @c_11503, @c_11504, @c_11505, 
    @c_11601, @c_11602, @c_11801, @c_11802, @c_11803, @c_11804] 
end

desc "Create the default periods"
task :default_periods => :environment do
  @p_2013 = create :period, year: 2013, explain:'2013年度预算'
end

desc "Create the default budget"
task :default_budgets => :environment do
  create :budget, period: @p_2013, category: @c_1
  create :budget, period: @p_2013, category: @c_101, amount: 200000 
  create :budget, period: @p_2013, category: @c_102, amount: 140000 
  create :budget, period: @p_2013, category: @c_10201
  create :budget, period: @p_2013, category: @c_10202
  create :budget, period: @p_2013, category: @c_10203
  create :budget, period: @p_2013, category: @c_103, amount: 100000 
  create :budget, period: @p_2013, category: @c_10301
  create :budget, period: @p_2013, category: @c_10302
  create :budget, period: @p_2013, category: @c_10303
  create :budget, period: @p_2013, category: @c_10304
  create :budget, period: @p_2013, category: @c_104, amount: 272300 
  create :budget, period: @p_2013, category: @c_10401
  create :budget, period: @p_2013, category: @c_10402
  create :budget, period: @p_2013, category: @c_10403
  create :budget, period: @p_2013, category: @c_10404
  create :budget, period: @p_2013, category: @c_10405
  create :budget, period: @p_2013, category: @c_10406
  create :budget, period: @p_2013, category: @c_10407
  create :budget, period: @p_2013, category: @c_105, amount: 870000 
  create :budget, period: @p_2013, category: @c_10501, amount: 500000 
  create :budget, period: @p_2013, category: @c_10502, amount: 300000 
  create :budget, period: @p_2013, category: @c_10503, amount: 60000 
  create :budget, period: @p_2013, category: @c_10504
  create :budget, period: @p_2013, category: @c_10505
  create :budget, period: @p_2013, category: @c_10506, amount: 10000 
  create :budget, period: @p_2013, category: @c_10507
  create :budget, period: @p_2013, category: @c_106, amount: 300000 
  create :budget, period: @p_2013, category: @c_107, amount: 50000 
  create :budget, period: @p_2013, category: @c_10701
  create :budget, period: @p_2013, category: @c_10702
  create :budget, period: @p_2013, category: @c_108, amount: 200000 
  create :budget, period: @p_2013, category: @c_10801
  create :budget, period: @p_2013, category: @c_10802
  create :budget, period: @p_2013, category: @c_109, amount: 166000 
  create :budget, period: @p_2013, category: @c_10901, amount: 16000 
  create :budget, period: @p_2013, category: @c_10902, amount: 150000 
  create :budget, period: @p_2013, category: @c_110, amount: 50000 
  create :budget, period: @p_2013, category: @c_111, amount: 100000 
  create :budget, period: @p_2013, category: @c_11101
  create :budget, period: @p_2013, category: @c_11102
  create :budget, period: @p_2013, category: @c_112, amount: 296000 
  create :budget, period: @p_2013, category: @c_11201, amount: 200000 
  create :budget, period: @p_2013, category: @c_11202
  create :budget, period: @p_2013, category: @c_11203, amount: 96000 
  create :budget, period: @p_2013, category: @c_11204
  create :budget, period: @p_2013, category: @c_11205
  create :budget, period: @p_2013, category: @c_113
  create :budget, period: @p_2013, category: @c_114
  create :budget, period: @p_2013, category: @c_11401
  create :budget, period: @p_2013, category: @c_11402
  create :budget, period: @p_2013, category: @c_115, amount: 100000 
  create :budget, period: @p_2013, category: @c_11501
  create :budget, period: @p_2013, category: @c_11502
  create :budget, period: @p_2013, category: @c_11503
  create :budget, period: @p_2013, category: @c_11504
  create :budget, period: @p_2013, category: @c_11505
  create :budget, period: @p_2013, category: @c_116, amount: 60000 
  create :budget, period: @p_2013, category: @c_11601
  create :budget, period: @p_2013, category: @c_11602, amount: 60000 
  create :budget, period: @p_2013, category: @c_117, amount: 150000 
  create :budget, period: @p_2013, category: @c_118, amount: 100000 
  create :budget, period: @p_2013, category: @c_11801
  create :budget, period: @p_2013, category: @c_11802
  create :budget, period: @p_2013, category: @c_11803
  create :budget, period: @p_2013, category: @c_11804
  create :budget, period: @p_2013, category: @c_2, amount: 2000000 
  create :budget, period: @p_2013, category: @c_201
  create :budget, period: @p_2013, category: @c_202
  create :budget, period: @p_2013, category: @c_203
  create :budget, period: @p_2013, category: @c_204
  create :budget, period: @p_2013, category: @c_205
  create :budget, period: @p_2013, category: @c_206
  create :budget, period: @p_2013, category: @c_207
  create :budget, period: @p_2013, category: @c_208
  create :budget, period: @p_2013, category: @c_209
  create :budget, period: @p_2013, category: @c_3, amount: 302000 
  create :budget, period: @p_2013, category: @c_301
  create :budget, period: @p_2013, category: @c_302
  create :budget, period: @p_2013, category: @c_303
  create :budget, period: @p_2013, category: @c_304
  create :budget, period: @p_2013, category: @c_4
  create :budget, period: @p_2013, category: @c_401
  create :budget, period: @p_2013, category: @c_402
  create :budget, period: @p_2013, category: @c_403
  create :budget, period: @p_2013, category: @c_5
  create :budget, period: @p_2013, category: @c_501
  create :budget, period: @p_2013, category: @c_502
  create :budget, period: @p_2013, category: @c_503
  create :budget, period: @p_2013, category: @c_504
  create :budget, period: @p_2013, category: @c_505
  create :budget, period: @p_2013, category: @c_506
  create :budget, period: @p_2013, category: @c_507
  create :budget, period: @p_2013, category: @c_508
  create :budget, period: @p_2013, category: @c_509
  create :budget, period: @p_2013, category: @c_510
  create :budget, period: @p_2013, category: @c_6
  create :budget, period: @p_2013, category: @c_601
  create :budget, period: @p_2013, category: @c_60101
  create :budget, period: @p_2013, category: @c_60102
  create :budget, period: @p_2013, category: @c_60103
  create :budget, period: @p_2013, category: @c_60104
  create :budget, period: @p_2013, category: @c_60105
  create :budget, period: @p_2013, category: @c_60106
  create :budget, period: @p_2013, category: @c_602
  create :budget, period: @p_2013, category: @c_60201
  create :budget, period: @p_2013, category: @c_60202
  create :budget, period: @p_2013, category: @c_60203
end

desc "Create the test users"
task :test_users => :environment do
  create :user,  username:'test', displayname:'测试用户', password:'a',
                 roles: %w[admin staff department_manager vice_manager financial_officer], 
                 organization: @xllg
end

desc "Run base tasks"
task :base => [ :admin_user, 
                :scaffold_organizations, :manager_users, :default_organizations, :default_users, 
                :default_categories, :default_periods, :default_budgets, 
                :test_users]