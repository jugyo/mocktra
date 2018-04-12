Mocktra
====

A webmock DSL using sinatra.

Installation
----

```bash
$ gem install mocktra
```

Examples
----

```ruby
require 'mocktra'

# define stub
Mocktra('www.example.com') do
  get '/foo' do
    'FOO!!'
  end

  post '/foo' do
    params.inspect
  end
end

# test it
require 'httpclient'
client = HTTPClient.new

res = client.get("http://www.example.com/foo")
p res.body
#=> "FOO!!"

res = client.post("http://www.example.com/foo", 'bar' => 'baz')
p res.body
#=> "{\"bar\"=>\"baz\"}"
```

Notice
----

Mocktra calls `WebMock.allow_net_connect!` when loading.

Copyright
----

Copyright (c) 2012 jugyo, released under the MIT license.
