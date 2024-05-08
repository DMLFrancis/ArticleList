require "test_helper"

class RetrieveArticlesTest < ActionDispatch::IntegrationTest

  test "should try to retrieve articles" do
    get "/articles"
    assert_response :success

    get "/articles"
    assert_response :ok
    assert_select "div[id^=article_]", 3
  end

end
