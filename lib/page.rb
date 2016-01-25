require 'nokogiri'
require 'open-uri'

class Page
  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def text
    @doc.css('h1, h2, h3, h4, h5, h6, p').collect {|x| x.text}.join(" ")
  end

  def title
    @doc.at_css('title').text
  end
end
