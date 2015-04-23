require "test_helper"

describe Comment do
  let(:comment) { build(:comment) }

  it "must be valid" do
    comment.must_be :valid?
  end

  it "同一用户同一节目应该只有一条短评" do
    user = comment.user
    program = comment.program
    comment.save
    invalid_comment = user.comments.build(:user_id => user.id, :program_id => program.id)
    invalid_comment.must_be :invalid?
  end

  it "短评内容和星级不能同时位空" do
    comment.content = ''
    comment.rank = nil
    comment.must_be :invalid?
  end

  it "短评内容应该大于7个字" do
    comment.content = '包含六个汉字'
    comment.must_be :invalid?
  end

  it "短评内容应该小于140个字" do
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a  
    newpass = ""  
    1.upto(135) { |i| newpass << chars[rand(chars.size-1)] }  

    comment.content = '包含六个汉字'+newpass
    comment.must_be :invalid?
  end

  it "同一用户同一节目应该只能评一次星" do
    user = comment.user
    program = comment.program
    comment.rank = 1
    comment.save

    af_comment = Comment.find_by(:user_id => user.id, :program_id => program.id)
    af_comment.rank = 4
    af_comment.save
    af_comment.rank.must_equal 1
  end
end
