FactoryGirl.define do

  # => 节目固件
  factory :program do
    sequence(:public_no){ |n| "Public#{n}" }
    sequence(:title){ |n| "Program#{n}" }
    sequence(:preview){ |n| "Preview#{n}" }
    cover Settings.default_cover
    sequence(:intro){ |n| "Introduction#{n}" }
    online_date '20150313090000'.to_time
    live_or_replay Program::TYPE[:live]
    categories ['Department1', 'Department2']
    organization 'Hospital'
    speakers ['Speaker1']

    # 直播类节目
    factory :live_program do
      live_or_replay 1
    end

    # 录播类节目
    factory :replay_program do
      live_or_replay 2
    end

    # => 封面为空的节目
    factory :no_cover_program do
      cover ''
    end

    factory :no_online_date_program do
      online_date nil
    end

    # => 未设置直播还是录播的节目
    factory :unknown_live_or_replay_program do
      live_or_replay nil
    end

    # => 未指定学科类型的节目
    factory :no_categories_program do
      categories nil
    end

    factory :never_expired_program do
      online_date Time.now + 1.day
    end

    factory :expired_program do
      online_date Time.now - 1.day
    end

  end
end
