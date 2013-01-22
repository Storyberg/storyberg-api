require 'spec_helper'

describe Storyberg do
  it 'sets and know the api_key' do
    Storyberg.api_key.should == 'sbk'
  end

  it 'makes an http request' do
    HTTParty.should_receive(:get).with("http://www.google.com")
    Storyberg.get("http://www.google.com")
  end

  it 'requires a key' do
    Storyberg.identify(1, {n: 'Salty Sealion'}).should == false
    Storyberg.record(1, {n: 'Salty Sealion'}).should == false
  end

  it 'identifies a user' do
    Storyberg.init('sbk', 'storyberg.dev')

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_users/identify?n=Salty+Sealion&k=sbk&u=1'

    Storyberg.identify 1, {n: 'Salty Sealion'}
  end

  it 'records activity against a user' do
    Storyberg.init('sbk', 'storyberg.dev')

    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_users/identify?a=1&k=sbk&u=1'
    HTTParty.should_receive(:get).with 'http://storyberg.dev/project_user_events/record?a=1&k=sbk&u=1'

    Storyberg.record 1, {a: 1}
  end

end
