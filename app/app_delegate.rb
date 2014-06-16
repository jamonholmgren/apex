class AppDelegate < Apex::Server
  port 8080

  get "/benchmark" do |r|
    $r = r
    "Hello World!"
  end

end
