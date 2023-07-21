require "test_helper"

class Public::JitikaiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_jitikai_index_url
    assert_response :success
  end

  test "should get show" do
    get public_jitikai_show_url
    assert_response :success
  end
end
