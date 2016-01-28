require 'rails_helper'

describe 'ArticleReadingSpec' do
  before do
    Capybara.current_driver = :poltergeist
  end
  it 'user should be able to read article at given speed and color theme' do
    visit "/users/sign_up"
    expect(page).to have_content("Sign up")

    within("#new_user") do
      fill_in('Username', with: 'user-example')
      fill_in('Email', with: 'user@example.com')
      fill_in('Password', with: 'password', match: :prefer_exact)
      fill_in('Password confirmation', with: 'password', match: :prefer_exact)
      click_button('Sign up')
    end
    expect(page).to have_content('Sign out')

    within("#new_article") do
      fill_in 'Url',with: 'https://medium.com/@sneha/64a0f1bee63b'
      click_button('Create Article')
    end

    within(".list-group .list-group-item") do
      expect(page).to have_content("Lorem Ipsum — Medium")
    end

    find_link("Lorem Ipsum — Medium").click
    within("#reader-container") do
      within(".well-lg") do
        expect(page).to have_content(article_text)
      end

      within(".nav-pills") do
        expect(page).to have_button('Read')
        expect(page).to have_button('Resume')
        expect(page).to have_button('Pause')
      end

      select_reading_speed('50wpm')
      select_color_scheme('random')

      click_button('Read')
      sleep(3)

      check_word_stream

      click_button('Pause')
      sleep(5)
      check_that_streaming_is_paused
    end

  end

  def check_word_stream
    (1..20).each do
      current_word = find('.word-container').text
      expect(article_text).to include(current_word)
    end
  end

  def check_that_streaming_is_paused
    current_word = find('.word-container').value

    (1..20).each do
      next_word = find('.word-container').value
      expect(next_word).to eq(current_word)
    end
  end

  def select_reading_speed(speed)
    within('.reading-speed') do
      find_link(speed, visible: false).trigger('click')
    end
  end

  def select_color_scheme(color_scheme)
    within('.color-scheme') do
      find_link(color_scheme, visible: false).trigger('click')
    end
  end

  def article_text
    "Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  end
end
