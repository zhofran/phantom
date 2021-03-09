require 'test_helper'

class ForumThreadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forum_threads_index_url
    assert_response :success
  end

end
