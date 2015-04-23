require "test_helper"

describe Interactive do
  let(:interactive) { build(:interactive) }

  it "must be valid" do
    interactive.must_be :valid?
  end

  describe "关于节目互动记录表" do

   it "当互动类型是问答时，必须有正确答案" do
     interactive.answer = ''
     interactive.must_be :invalid?
   end

   it "当有正确答案时，答案必须在选项内" do
    interactive.selections = ['选项1', '选项2', '选项3', '选项4']
   	interactive.answer = '选项5'
   	interactive.must_be :invalid?
   end

   it "节目互动内容表的是否多选为否时，正确答案为单个的值" do
    interactive.multiple =  false
    interactive.answer = ['A', 'B', 'C', 'D']
    interactive.must_be :invalid?
   end
 end

end
