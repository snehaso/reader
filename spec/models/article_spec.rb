require 'rails_helper'

describe Article do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:user) }

  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should belong_to(:user) }
end
