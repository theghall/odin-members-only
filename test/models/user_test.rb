require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should not allow blank username" do
    @user.username = ' '
    assert_not @user.valid?
  end

  test "should not allow duplicate username" do
    user = User.new(username: @user.username, email: 'anotheruser', password: 'password')
    assert_no_difference 'User.count' do
      user.save
    end
  end

  test "should not allow blank email" do
    @user.email = ' '
    assert_not @user.valid?
  end

  test "should not allow duplicate email" do
    user = User.new(username: 'anotheruser', email: @user.email, password: 'password')
    assert_no_difference 'User.count' do
      user.save
    end

  end

  test "should not allow blank password" do
    user = User.new(username: 'xxx', email: 'xxxx', password: ' ')
    assert_not user.valid?
  end

  test "should not allow short password" do
    user = User.new(username: 'xxx', email: 'xxxx', password: '12345')
    assert_not user.valid?
  end

  test "should allow password of length 6" do
    user = User.new(username: 'xxx', email: 'xxxx', password: '123456')
    assert user.valid?
  end

end
