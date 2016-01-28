class Article < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :url
end
