require 'page'

class Article < ActiveRecord::Base
  belongs_to :user
  before_create :extract_text

  validates_presence_of :user, :url

  WORDS_IN_SHORT_TEXT = 50

  def short_text
    text.split.first(WORDS_IN_SHORT_TEXT).join(' ')
  end

  private
  def extract_text
    unless text
      page = Page.new(url)
      self.text = page.text
      self.title = page.title
    end
  end
end
