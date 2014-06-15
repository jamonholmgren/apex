class AppDelegate < Apex::Server
  port 8080

  get "/benchmark" do |r|
    "Hello " + r.to_s
  end

end
