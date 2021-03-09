require 'test_helper'

class ForumPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forum_posts_index_url
    assert_response :success
  end

end
