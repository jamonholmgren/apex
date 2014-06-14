class AppDelegate < Apex::Server
  port 8080

  layout do
    "<html>" +
    "<head><title>Apex</title></head>" +
    "<body>" +
    content +
    "</body>" +
    "</html>"
  end

  get "/" do |r|
    $r = r
    "<h1>Apex is running. Response: #{r}</h1>" +
    "<p><a href='/about'>About Apex</a></p>"
  end

  get "/about" do |r|
    $r = r
    "<h1>About Apex</h1>" +
    "<p><a href='/'>Home</a></p>"
  end

end
