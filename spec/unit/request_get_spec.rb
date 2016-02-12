describe "Apex::Request" do

  def headers
    {
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
      "Accept-Encoding" => "gzip,deflate,sdch",
      "Cookie" => "user_id=USER_ID; __atuvc=0%7C17",
      "Host" => "localhost:8080",
      "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36",
      "Accept-Language" => "en-US,en;q=0.8,sk;q=0.6,es;q=0.4",
      "Cache-Control" => "max-age=0",
      "Connection" => "keep-alive"
    }
  end

  def query
    { "test" => "tested" }
  end

  def raw_request(req_type = :get)
    @_raw_requests ||= {}
    @_raw_requests[req_type] ||= GCDWebServerRequest.alloc.initWithMethod(req_type.to_s.upcase, url: "http://localhost:8080", headers: headers, path:"/benchmark", query: query)
  end

  def request(req_type = :get)
    @_request ||= {}
    @_request[req_type] ||= Apex::Request.new(raw_request(req_type))
  end

  it "#raw" do
    request.raw.should == raw_request
  end

  it "#body?" do
    request.body?.should.be.false
  end

  it "#content_type" do
    request.content_type.should.be.nil
  end

  it "#headers" do
    request.headers.should == headers
  end

  it "#content_length" do
    request.content_length.should == 9223372036854775807
  end

  it "#query" do
    request.query.should == query
  end

  it "#path" do
    request.path.should == "/benchmark"
  end

  it "#url" do
    request.url.should == "http://localhost:8080"
  end

  it "#params" do
    request.query.should == query
    request.params.should == query
  end

  [:get, :post, :patch, :delete].each do |req_type|
    describe "#{req_type.to_s.upcase} Requests" do
      it "#method" do
        request(req_type).method.should == req_type.to_s.upcase
      end

      it "#req_type?" do
        request(req_type).send("#{req_type}?").should.be.true
      end
    end
  end
end
