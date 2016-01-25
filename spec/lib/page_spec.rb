require 'rails_helper'

describe Page do
  it 'extract text from a page' do
    allow_any_instance_of(Page)
      .to receive(:open)
      .with('https://site-1.com')
      .and_return(IO.read(Rails.root.join("spec", "data", "example.html")))
    page = Page.new("https://site-1.com")

    expect(page.title).to eq('Trek to Triund — Sneha’s travel diary — Medium')
    expect(page.text).to eq(output_text)
  end

  def output_text
    "Published inSneha’s travel diary Trek to Triund In May 2015, I visited McLeodGanj and stayed at hotel Greenwood Inn (recommended). My hotel receptionist suggested that Triund provides the best view of the Dhauladhar mountains. He confidently called out the trek as an easy one. Thanks to him, he encouraged me and my husband to trek to Triund. It was not an easy one though. This is what Triund looked like from my hotel Terrace. Triund is located somewhere near the dark green hump you see in this picture, below the snow capped mountain peaks. We left hotel at 8am and walked to Dharamkot Chowk. The road was quiet, green and full of small rocks. At Dharamkot, we took a shortcut behind the transformer. We walked through a pine forest for an hour and reached Golu devi mata mandir. Most tourists drive till this point and then start the climb. You will find the small tea/cold-drink huts every few kms. As the altitude increased, we took more breaks. Gatorade helped us keep our pace. The last 2 kms were the most difficult and it took us 2 hours to climb the last stretch. On the way, we met shepherds. They travel up after February with sheep. In later half of the summer, they even go further by crossing Triund. In summer, shepherds stay in open with their sheep. As we progressed,the terrain changed. We were walking over sedimentary rocks around a large valley full of pine trees. After walking for 5 hours, we finally reached our destination. After a turn, suddenly snow capped mountains appeared in front of us. Here is that picturesque view. There were already 30–40 people roaming around. The natives were selling maggie and tea. One could rent the tents for 700INR and stay overnight, but the place was noisy. A large group was playing loud music hence we decide to get back. The view is totally worth the difficult climb. We reached back hotel at 8pm. We trekked total of 18km. If you are visiting Dharamshala, don’t miss Triund. Sneha Somwanshi Ruby developer @ThoughtWorks , DevOps Enthusiast, Indian. Sneha’s travel diary my experiences during travels Next stories from your reading list Angular 2 First App Post-Mortem Why Silicon Valley Will Continue to Rule 10 Habits Of Unsuccessful People You Don’t Want To Copy Why Your Company Should Adopt Innovation Days A cartoon guide to Facebook’s Relay, part 1"
  end
end
