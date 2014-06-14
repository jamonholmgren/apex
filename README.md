# apex

Apex is a RubyMotion web framework for OS X. It uses
GCDWebServer under the hood and provides a Sinatra-like
router and DSL.

Apex is currently experimental and in development. I'd
love to have help; feel free get in touch [on Twitter](http://twitter.com/jamonholmgren).

## Installation

```ruby
gem 'apex'
```

## Usage

```ruby
class AppDelegate < Apex::Server
  port 8080 # defaults to 8080

  layout do
    "<html>" +
    "<head><title>Apex</title></head>" +
    "<body>" +
    content +
    "</body>" +
    "</html>"
  end

  get "/" do |r|
    "<h1>Apex is running. Response: #{r}</h1>" +
    "<p><a href='/about'>About Apex</a></p>"
  end

  get "/about" do |r|
    "<h1>About Apex</h1>" +
    "<p><a href='/'>Home</a></p>"
  end

  post "/some_post" do |request|
    request.headers["User-Agent"]
  end

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
