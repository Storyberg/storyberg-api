require 'spec_helper'

describe Storyberg do
  it 'sets and know the api_key' do
    Storyberg.init 'sbk', 'storyberg.dev'

    Storyberg.api_key.should == 'sbk'
  end

  it 'makes an http request' do
    HTTParty.should_receive(:get).with "http://www.google.com"
    Storyberg.get 'http://www.google.com'
  end

  it 'requires a key' do
    Storyberg.init nil

    Storyberg.identify(1).should == false

    Storyberg.record(1).should == false
  end

  it 'identifies a user' do
    Storyberg.init 'sbk', 'storyberg.dev'

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_users/identify.json?name=Salty+Sealion&api_key=sbk&user_id=1'

    Storyberg.identify 1, {name: 'Salty Sealion'}
  end

  it 'can identify with a tag' do
    Storyberg.init 'sbk', 'storyberg.dev'

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_users/identify.json?name=Salty+Sealion&api_key=sbk&user_id=1&sb_tag=email_campaign'

    Storyberg.identify(1, {name: 'Salty Sealion', tag: 'email_campaign'})
  end

  it 'records key events against a user' do
    Storyberg.init('sbk', 'storyberg.dev')

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_user_events/create.json?api_key=sbk&sb_event=key&user_id=1'

    Storyberg.record 1
  end

  it 'records paid events against a user' do
    Storyberg.init('sbk', 'storyberg.dev')

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_user_events/create.json?api_key=sbk&sb_event=paid&user_id=1'

    Storyberg.paid 1
  end

  it 'records any type of events against a user' do
    Storyberg.init('sbk', 'storyberg.dev')

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_user_events/create.json?api_key=sbk&sb_event=watched_video&user_id=1'

    Storyberg.event 'watched_video', 1
  end
end
