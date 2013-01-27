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


    Storyberg.identify(1, {name: 'Salty Sealion'}).should == false

    Storyberg.record(1, {name: 'Salty Sealion'}).should == false
  end

  it 'identifies a user' do
    Storyberg.init 'sbk', 'storyberg.dev'

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_users/identify.json?name=Salty+Sealion&api_key=sbk&user_id=1'

    Storyberg.identify 1, {name: 'Salty Sealion'}
  end

  it 'records activity against a user' do
    Storyberg.init('sbk', 'storyberg.dev')

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_users/identify.json?account_id=1&api_key=sbk&user_id=1'
    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_user_events/record.json?account_id=1&api_key=sbk&user_id=1'

    Storyberg.record 1, {account_id: 1}
  end

end
