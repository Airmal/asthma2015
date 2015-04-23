FactoryGirl.define do
  factory :courseware do
    uploader
    type Courseware::TYPE[:remote_video_with_local_doc]
    sequence(:name){ |n| "Courseware #{n}" }
    remote_url Settings.default_remote_url
    file_path Settings.default_file_path
    tags ['Department1', 'Tag2']
    verified true
    downloadable true
    point 2
    program
  end
end
