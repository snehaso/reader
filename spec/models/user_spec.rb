require 'rails_helper'

describe User do
  it "valid with a valid email and password" do
    user = create(:user)
    user.password_confirmation = user.password
    assert user.valid?, 'user is invalid with valid email and password'
  end
end
