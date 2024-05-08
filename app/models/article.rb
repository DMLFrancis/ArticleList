class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def get_article_status
    if(self.published)
      return "Published"
    else
      return "Not Published"
    end
  end
end
