require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @post = posts(:first)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should not allow nil user_id" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "should not allow blank title" do
    @post.title = ' '
    assert_not @post.valid?
  end

  test "should not allow dupe title" do
    post = @post
    assert_no_difference 'Post.count' do
      post.save
    end
  end

  test "should not allow blank body" do
    @post.body = ' '
    assert_not @post.valid?
  end

  test "should set default value to false" do
    post = Post.create(title: 'title', body: 'body')

    assert_equal false, post.flagged
  end
end
