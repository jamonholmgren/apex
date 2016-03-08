class AppDelegate < Apex::Server
  port 8081

  get "/benchmark" do |r|
    $r = r
    "Hello World!"
  end

  get ["/testing", "/testing.html"] do |t|
    $t = t
    "Testing"
  end

end
