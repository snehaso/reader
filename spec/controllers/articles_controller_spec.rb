require 'rails_helper'

describe ArticlesController do
  include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @user = create(:user)
    sign_in(@user)
  end

  it 'list articles read by user' do
    articles_owned_by_user = create_list(:article, 2, user: @user)
    create_list(:article, 2, user: create(:user))

    get :index

    expect(assigns(:articles)).to eq(articles_owned_by_user)
  end

  it 'create new article for given url' do
    allow(Page).to receive(:new).and_return(double(:page, title: 'Title 1',  text: 'Text'))

    post :create, {article: {url: 'http://medium.com/blog-1'}}

    article = Article.find_by_url('http://medium.com/blog-1')
    expect(article).to be_present
    expect(response).to redirect_to(articles_path)
  end
end
