require 'page'

class Article < ActiveRecord::Base
  belongs_to :user
  before_create :extract_text

  validates_presence_of :user, :url

  private
  def extract_text
    page = Page.new(url)
    self.text = page.text
    self.title = page.title
  end
end
