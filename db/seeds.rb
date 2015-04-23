# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

programs = Program.first_or_create([
  { :public_no => 'XY-001', 
    :title => '远离威胁儿童生命的“头号杀手”——儿童急性早幼粒细胞白血病', 
    :preview => '云医首期直播节目将邀请到北京大学血液病研究所黄晓军教授', 
    :intro => '儿童急性早幼粒细胞白血病是...',
    :online_date => '20150328090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['黄晓军教授'], 
    :organization => '北京大学血液病研究所'
  },
  { :public_no => 'XY-002', 
    :title => '拯救白血病', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150401090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['胡豫主任'], 
    :organization => '武汉协和医院' 
  },
  { :public_no => 'XY-003', 
    :title => '来自血液的危险信号：骨髓增生异常综合征', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150404090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['路瑾主任'], 
    :organization => '武汉协和医院' 
  },
  { :public_no => 'XY-004', 
    :title => '别忽视难止的血——轻度血友病症状隐匿', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150408090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['李娟主任'], 
    :organization => '中山大学附属第一医院' 
  },
  { :public_no => 'XY-005', 
    :title => '长期低烧，小心“慢粒”白血病', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150411090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['江倩主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-006', 
    :title => '在垂死线上挣扎的病---地贫', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150415090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['刘开彦主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-007', 
    :title => '向多发性骨髓瘤宣战', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150418090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['肖志坚主任'], 
    :organization => '上海瑞金医院' 
  },
  { :public_no => 'XY-008', 
    :title => '再障患者的康复之路', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150422090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['李娟主任'], 
    :organization => '中山大学附属第一医院' 
  },
  { :public_no => 'XY-009', 
    :title => '科学防治溶血性贫血', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150425090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['路瑾主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-010', 
    :title => '生命不能承受之痛——淋巴瘤', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150428090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['胡豫主任'], 
    :organization => '武汉协和医院' 
  },
  { :public_no => 'XY-011', 
    :title => '不容小觑的“贫血”——巨幼细胞贫血', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150502090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['刘开彦主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-012', 
    :title => '孕前筛查 别让白血病与生俱来——地贫', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150506090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['路瑾主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-013', 
    :title => '警惕血管性紫癜---特发性血小板减少性紫癜血栓性血小板减少紫癜', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150509090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['江倩主任'], 
    :organization => '北京大学人民医院'
  },
  { :public_no => 'XY-014', 
    :title => '挽救癌变的血液——慢性淋巴细胞白血病', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150513090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['胡豫主任'], 
    :organization => '武汉协和医院' 
  },
  { :public_no => 'XY-015', 
    :title => '斩断病魔的利剑——原发性骨髓纤维化', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150516090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['肖志坚主任'], 
    :organization => '上海瑞金医院' 
  },
  { :public_no => 'XY-016', 
    :title => '不可忽视的“淤青”---过敏性紫癜', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150520090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['刘开彦主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-017', 
    :title => '科学认识DIC及脾功能亢进', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150523090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['李军民主任'], 
    :organization => '上海瑞金医院' 
  },
  { :public_no => 'XY-018', 
    :title => '谈“血癌”的分层诊断治疗', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150527090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['江倩主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-019', 
    :title => '战胜血液顽疾——白血病的化学药物治疗', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150530090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['胡豫主任'], 
    :organization => '武汉协和医院' 
  },
  { :public_no => 'XY-020', 
    :title => '白血病是不治之症吗？——白血病的检查', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150603090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['李娟主任'], 
    :organization => '中山大学附属第一医院' 
  },
  { :public_no => 'XY-021', 
    :title => '治疗慢粒白血病别忽视规范监测', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150606090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['李军民主任'], 
    :organization => '上海瑞金医院' 
  },
  { :public_no => 'XY-022', 
    :title => '战胜血液顽疾——白血病的生物治疗', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150610090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['刘开彦主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-023', 
    :title => '战胜血液顽疾——白血病的骨髓移植治疗', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150613090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['孙自敏主任'], 
    :organization => '安徽省立医院' 
  },
  { :public_no => 'XY-024', 
    :title => '急性髓细胞白血病 尚未远去的阴影', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150617090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['肖志坚主任'], 
    :organization => '中国医学科学院血液学研究所血液病医院' 
  },
  { :public_no => 'XY-025', 
    :title => '慢性髓细胞白血病药物治疗不能慢', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150620090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['张晓辉主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-026', 
    :title => '战胜血液顽疾——白血病的放射治疗及中医治疗', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150624090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['刘开彦主任'], 
    :organization => '北京大学人民医院' 
  },
  { :public_no => 'XY-027', 
    :title => '希望在前方--拯救“玻璃人”', 
    :preview => '', 
    :intro => '...',
    :online_date => '20150627090000'.to_datetime,
    :live_or_replay => 1,
    :categories => ['血液科'],
    :speakers => ['王建祥主任'], 
    :organization => '中国医学科学院血液学研究所血液病医院' 
  }
]);


coursewares = Courseware.first_or_create([
  { :uploader_id => 1,
    :type_of_courseware => 3,
   :name=>'test',
   :remote_url => 'http://weblbs.yystatic.com/s/72/2320351795/medicalscene.swf',
   :tags => '血液科',
   :program_id => 1,
   :remote_or_local => 1
  }
]);

admin = Admin.create([
  { :email => '277434795@163.com',
    :password => '12345678',
    :administrator_flg => '0'
  }
]);

require 'securerandom'
  array = Array.new
  100000.times do
    array.push(SecureRandom.hex(4))
  end

  while array.uniq.length < 100000 do
    array.push(SecureRandom.hex(4))
  end

  array.uniq.each do | secure |
    Invitate.create({
      invitate_cd: secure,
      batch: Time.now.strftime("%Y%m%d")
    })
  end