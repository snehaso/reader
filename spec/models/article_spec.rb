require 'rails_helper'

describe Article do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:user) }

  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should respond_to(:text) }
  it { should belong_to(:user) }

  it "extract text from given url" do
    allow(Page).to receive(:new)
    .and_return(double(:page, title: 'Title 1',  text: 'Text to store in database for a user'))

    article = Article.create!(url: "https://site-1.com", user: create(:user))

    expect(article.url).to eq("https://site-1.com")
    expect(article.title).to eq("Title 1")
    expect(article.text).to eq("Text to store in database for a user")
  end

  it "populate error if text extraction failed" do
    allow(Page).to receive(:new).and_raise('Could not fetch url')

    article = Article.create!(url: "https://site-1.com", user: create(:user))

    expect(article.url).to eq("https://site-1.com")
    expect(article.title).to be_nil
    expect(article.text).to be_nil
    expect(article.errors.full_messages.first).to eq('Url Failed to fetch text from article url')
  end

  it "short text for displaying article" do
    article = create(:article, url: "https://site-1.com", text: "random " * 70, title: 'title-1')
    expect(article.short_text).to eq(("random " * Article::WORDS_IN_SHORT_TEXT).strip)
  end

  it "ignore the articles without text" do
    user = create(:user)
    failed_articles = create_list(:article, 3, user: user, text: '')
    successful_articles = create_list(:article, 3, user: user, text: 'text extracted successfully')

    expect(Article.all).to eq(successful_articles)
  end
end
