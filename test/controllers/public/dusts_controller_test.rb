require "test_helper"

class Public::DustsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_dusts_index_url
    assert_response :success
  end

  test "should get show" do
    get public_dusts_show_url
    assert_response :success
  end
end
