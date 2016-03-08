describe "Apex::Server" do

  class BlankServer < Apex::Server
  end

  class PortServer < Apex::Server
    port 8085
  end

  class RouteServer < Apex::Server
    get '/test' do |r|
      "response"
    end
  end

  class MultiRouteServer < Apex::Server
    get ['/test', '/anothertest'] do |r|
      "response"
    end
  end

  before do
    @blank      = BlankServer.new
    @port       = PortServer.new
    @route      = RouteServer.new
    @multiroute = MultiRouteServer.new

    @servers = [@blank, @port, @route, @multiroute]
  end

  after do
    # Stop and delete the servers.
    @servers.each do |s|
      s.stop
      s = nil
    end
  end

  it "should be a GCDWebServer" do
    @blank.server.is_a?(GCDWebServer).should == true
  end

  it "should start the server" do
    @blank.server.isRunning.should == false
    @blank.start
    wait 0.5 do
      @blank.server.isRunning.should == true
    end
  end

  it "should have a default port" do
    @blank.port.should == 8080
    @blank.start
    wait 0.5 do
      @blank.server.port.should == 8080
    end
  end

  it "should have a customizable port" do
    @port.port.should == 8085
    @port.start
    wait 0.5 do
      @port.server.port.should == 8085
    end
  end

  it "should have routes" do
    routes = @route.routes[:get]
    routes.is_a?(Hash).should == true
    routes.count.should == 1

    routes['/test'][:handler].call.should == "response"
  end

  it "should have multiple routes with the same responder" do
    routes = @multiroute.routes[:get]
    routes.count.should == 2

    routes['/test'][:handler].call.should == "response"
    routes['/anothertest'][:handler].call.should == "response"
  end

  # TODO - implement this test. It's failing for some reason because the
  # the response is nil.

  # it "should serve assets from resources/assets" do
  #   url = NSURL.URLWithString("http://localhost:8080/somefile.txt")
  #
  #   session = NSURLSession.sharedSession
  #   session.dataTaskWithURL(url, completionHandler: -> data, response, error {
  #     @response = {
  #       string: NSString.alloc.initWithData(data, encoding:NSUTF8StringEncoding),
  #       data: data,
  #       response: response,
  #       erorr: error,
  #     }
  #     resume
  #   }).resume
  #
  #   wait do
  #     @response[:error].should.be.nil
  #     @response[:string].should == "somefile contents\n"
  #     @response[:response].statusCode.should == 200
  #   end
  # end

end
