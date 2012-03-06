require 'spec_helper'

describe Mocktra do
  it 'works' do
    Mocktra('www.example.com') do
      get '/foo' do
        'FOO!!'
      end

      post '/foo' do
        params.inspect
      end
    end

    require 'httpclient'
    client = HTTPClient.new

    res = client.get("http://www.example.com/foo")
    res.body.should == 'FOO!!'

    res = client.post("http://www.example.com/foo", 'bar' => 'baz')
    res.body.should == '{"bar"=>"baz"}'
  end
end