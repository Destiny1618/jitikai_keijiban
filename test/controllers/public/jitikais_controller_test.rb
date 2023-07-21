require "test_helper"

class Public::JitikaisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_jitikais_index_url
    assert_response :success
  end

  test "should get show" do
    get public_jitikais_show_url
    assert_response :success
  end
end
