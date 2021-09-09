require "test_helper"

class ExamControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get exam_register_url
    assert_response :success
  end
end
