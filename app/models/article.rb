require 'page'

class Article < ActiveRecord::Base
  belongs_to :user
  before_create :extract_text

  validates_presence_of :user, :url

  default_scope { where("text <> ''") }

  WORDS_IN_SHORT_TEXT = 50

  def short_text
    text.split.first(WORDS_IN_SHORT_TEXT).join(' ')
  end

  private
  def extract_text
    unless text
      begin
        # Note: Ideally failed articles should be handled by a worker. The worker
        # will retry fetch text of failed articles. Also we should also show a
        # separate listing of failed articles to user.
        page = Page.new(url)
        self.text = page.text
        self.title = page.title
      rescue Exception => ex
        errors.add(:url, 'Failed to fetch text from article url')
        Rails.logger.error("Failed to extract text from url #{url} Exception #{ex.message}")
      end
    end
  end
end
