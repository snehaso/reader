require 'rails_helper'

describe ArticlesController do
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
  end

  it 'should list articles read by user' do
    another_user, user = create_list(:user, 2)
    sign_in(user)

    articles_owned_by_user = create_list(:article, 2, user: user)
    create_list(:article, 2, user: another_user)

    get :index

    expect(assigns(:articles)).to eq(articles_owned_by_user)
  end
end
