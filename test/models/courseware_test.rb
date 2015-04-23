require "test_helper"

describe Courseware do
  let(:courseware) { build(:courseware) }

  it "must be valid" do
    courseware.must_be :valid?
  end

  it "节目是直播的时候，远端地址不能为空" do
  	courseware.type = Courseware::TYPE[:remote_video_with_local_doc]
  	courseware.remote_url = ''
    courseware.must_be :invalid?
  end

  it "节目是直播的时候，应该采用远端地址（remote_or_local ＝ 1）" do
  	courseware.type = Courseware::TYPE[:remote_video_with_local_doc]
  	courseware.remote_or_local = 99
  	courseware.save
    courseware.remote_or_local.must_equal Courseware::REMOTE_OR_LOCAL[:remote]
  end


end
