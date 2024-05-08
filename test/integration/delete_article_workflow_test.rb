require "test_helper"

class DeleteArticleWorkflowTest < ActionDispatch::IntegrationTest

  test "Should delete the Test Article 1" do
    article = articles(:test_article_published_task)

    get "/articles"
    assert_response :success
    assert_select "div[id^=article_]", 3

    delete "/articles/#{article.id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/articles"
    assert_response :success
    assert_select "div[id^=article_]", 2
  end

end
