require 'test_helper'

class MembersOnlyTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:frank)    
    @post = posts(:first)
  end

  test "should redirect on new post if not logged in" do
    get new_post_url
    assert_redirected_to login_url
  end

  test "should redirect if try to post if not logged in" do
    post posts_url, params: {post: {title: 'xxxx', body: 'yyyy'}}
    assert_redirected_to login_url
  end

  test "should see posts without logging in" do
    get root_url
    assert_select 'div.post', Post.count
  end

  test "should add post" do
    log_in_as(@user)
    get root_url
    assert_select 'div.post', Post.count
    assert_difference 'Post.count', 1 do
      post posts_url, params: {post: {title: 'xxxx', body: 'yyyy'}}
    end
  end

  test 'should mark post as flagged for review when not logged in' do
    get root_url
    patch post_path(@post), params: {post: { flagged: true }}
    @post.reload
    assert_equal @post.flagged, true
  end

  test 'should mark post as flagged for review when logged in' do
    log_in_as(@user)
    get root_url
    get root_url
    patch post_path(@post), params: {post: { flagged: true }}
    @post.reload
    assert_equal @post.flagged, true
  end


end
