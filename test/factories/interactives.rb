FactoryGirl.define do
  factory :interactive do
    type_of_interactive Interactive::TYPE[:choices]
    sequence(:title){ |n| "Title#{n}" }
    selections ['选项1', '选项2', '选项3', '选项4']
    answer '选项1'
    multiple false
  end
end
