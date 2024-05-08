require "test_helper"

class CreateArticleWorkflowTest < ActionDispatch::IntegrationTest

  test "should try to create a new article that is publised" do
    get "/articles/new"
    assert_response :success

    post "/articles", params: { article: { title: "Integration Test", body: "Integration Test", published: true } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/articles"
    assert_response :ok
    assert_select "div[id^=article_]", 4
    assert_select "div[id^=article_] p", /Title:\s*Integration Test/
    assert_select "div[id^=article_] p", /Body:\s*Integration Test/
    assert_select "div[id^=article_] p strong", text: "Published"
  end

  test "should try to create a new article that is not publised" do
    get "/articles/new"
    assert_response :success

    post "/articles", params: { article: { title: "Not Published", body: "Integration Test", published: false } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/articles"
    assert_response :ok
    assert_select "div[id^=article_]", 4
    assert_select "div[id^=article_] p", /Title:\s*Not Published/
    assert_select "div[id^=article_] p", /Body:\s*Integration Test/
    assert_select "div[id^=article_] p strong", text: "Not Published"
  end

end
