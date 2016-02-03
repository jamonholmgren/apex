# apex

Apex is a RubyMotion web framework for OS X. It uses
GCDWebServer under the hood and provides a Sinatra-like
router and DSL.

Apex is currently experimental and in development. Let me know
what you think [on Twitter](http://twitter.com/jamonholmgren).

Apex is a research project of ![Infinite Red](http://infinite.red), a web and mobile development company based in Portland, OR and San Francisco, CA.

## Installation

```ruby
# In Gemfile:
gem 'apex', :git => 'https://github.com/infinitered/apex.git'

# In Terminal:
bundle install
rake pod:install
```

## Usage

### Using your AppDelegate

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

#### Alternate Railsy Syntax

This is under consideration.

```ruby
class AppDelegate < Apex::Server
  def routes
    get "/", controller: HomeController, action: :home
    get "/about", controller: AboutController, action: :about
    get "/about/me", controller: AboutController, action: :me
  end
end

class HomeController < Apex::Controller
  def home
    render :home, layout: DefaultLayout
  end
end

class AboutController < Apex::Controller
  layout AboutLayout

  def about
    render :about
  end
  
  def me
    render :me, name: "Jamon"
  end
end

def AboutView < Apex::View
  def about
    "<h1>About</h1>"
  end
  
  def me(args={})
    "<h1>Me #{args[:name]}</h1>"
  end
end

def AboutLayout < Apex::Layout
  def render
    "<html>" +
      "<head>" +
        "<title>#{title}</title>" +
      "</head>" +
      "<body>#{content}</body>" +
    "</html>"
  end
  
  # Potentially, a Ruby DSL for HTML:
  def render
    html do
      head do
        title "My title"
      end
      body do
        content_for :body
      end
    end
  end
end
```

### Standalone class

```ruby

class WebServer < Apex::Server
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

Then in your AppDelegate (or wherever you'd like to start your server):

```ruby
@server = WebServer.new
@server.start_server
```

## JSON

You can also return json. You can specify the response_type, like so:

```ruby
get "/current_user", response_type: :json do |request|
  {
    name: 'Todd',
    age: 21
  }
end  
```

Or it will auto-detect the repsonse type if you return a hash instead of a string:
```ruby
get "/current_user" do |request|
  {
    name: 'Todd',
    age: 21
  }
end  
```

## Benchmarking

Somewhat useless (but still fun) benchmarking against a minimal Node.js/Express app
shows Apex serving requests about 1.4x as fast as Node.

```sh-session
# Node.js / express.js app found in ./benchmarks/node/app.js
$ ab -r -n 10000 -c 6 -r http://192.168.1.246:8081/benchmark | grep "Requests per second"
Requests per second:    2789.32 [#/sec] (mean)
# Apex server found in ./app/app_delegate.rb
$ ab -r -n 10000 -c 6 -r http://192.168.1.246:8080/benchmark | grep "Requests per second"
Requests per second:    3862.26 [#/sec] (mean)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
