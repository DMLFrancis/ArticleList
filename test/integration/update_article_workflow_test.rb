require "test_helper"

class EditArticleWorkflowTest < ActionDispatch::IntegrationTest

  test "Should edit the Test Article 1" do
    article = articles(:test_article_published_task)
    get "/articles/#{article.id}/edit"
    assert_response :success

    patch "/articles/#{article.id}", params: { article: { title: "Integration Edit", published: false } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/articles"
    assert_response :success
    assert_select "div[id^=article_]", 3
    assert_select "div[id^=article_] p", /Title:\s*Integration Edit/
    assert_select "div[id^=article_] p strong", text: "Not Published"
  end
  
end
