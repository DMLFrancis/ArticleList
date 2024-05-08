require "test_helper"

class ArticleTest < ActiveSupport::TestCase

#Set-up @article = Article.new before every test
#And
#Set-up @test_article = articles(:test_article_published_task) before every test
#And
#Set-up @false_test_article = articles(:test_article_not_published_task)

  setup do
    @article = Article.new
    @test_article = articles(:test_article_published_task)
    @false_test_article = articles(:test_article_not_published_task)
  end

#Tear-down to run after every test
#  teardown do
#    puts("This runs after the tests")
#  end

#Testing if application can save an Article
test "Should save an article" do
  article = Article.new(title: "Valid Title", body: "Valid Body")
  assert article.save
end


#Testing if application can find an Article
  test "Should find an article" do
    @article.title = "Finding an article"
    @article.body = "This is a test for finding an article"
    @article.published = false
    @article.save

    expected_article = Article.find(@article.id)
    assert_equal(expected_article.title, @article.title)
    assert_equal(expected_article.published, @article.published)
  end

#Testing if application can delete an Article
test "Should delete an article" do
  article = articles(:test_article_published_task) # Assuming you're using fixtures or some other method to create articles
  assert_difference('Article.count', -1) do
    article.destroy
  end
end


#Testing if application can update an Article
#(test_article_published_task found in test/fixtures/articles.yml)
  test "Should update an article" do
    test_updated_title = "Testing title update"
    @test_article.update({
      title: test_updated_title
    })
    assert_equal(test_updated_title, @test_article.title)
  end

#Testing if application can display published when true
  test "Should be published when true" do
    assert_equal(@test_article.get_article_status(), "Published")
  end

#Testing if application can display not published when false
  test "Should be not published when false" do
    assert_equal(@false_test_article.get_article_status(), "Not Published")
  end

end
