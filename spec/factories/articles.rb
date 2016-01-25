FactoryGirl.define do
  factory :article do
    sequence(:url) { |n| "https://medium.com/@sneha/trek-to-triund{n}" }
    title 'Trek to Triund'
    text 'This is what Triund looked like from my hotel Terrace. Triund is located somewhere near the dark green hump you see in this picture, below the snow capped mountain peaks.'
    user
  end
end
