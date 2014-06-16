module Apex
  class Server
    include DelegateInterface

    def on_launch
      return true if RUBYMOTION_ENV == "test"
      add_static_handler
      add_app_handlers
      start
    end

    def server
      @server ||= GCDWebServer.new
    end

    def routes
      self.class.routes
    end

    def layouts
      self.class.layouts
    end

    def add_app_handlers
      [ :get, :post, :put, :patch, :delete ].each do |verb|
        self.server.addDefaultHandlerForMethod(verb.to_s.upcase,
          requestClass: GCDWebServerRequest,
          processBlock: -> (raw_request) {
            layout = false
            request = Request.new(raw_request)
            if response_block = self.routes[verb][request.path][:handler] rescue nil
              request_args = [request].first(response_block.arity)
              response = response_block.call(*request_args)
              layout = self.routes[verb][request.path][:layout]
            else
              response = "<h1>404 not found</h1>"
            end
            GCDWebServerDataResponse.responseWithHTML apply_layout(response, layout)
          }
        )
      end
    end

    def apply_layout(response, name)
      layouts[name] ? layouts[name].call.to_s.gsub(self.class.content(:main), response) : response
    end

    def add_static_handler
      public_path = NSBundle.mainBundle.pathForResource("assets", ofType:nil)
      self.server.addGETHandlerForBasePath("/", directoryPath:public_path, indexFilename:nil, cacheAge:3600, allowRangeRequests:false)
    end

    def start
      server.runWithPort self.class.port, bonjourName: nil
    end

    # Class methods *************************

    def self.get(path, args={}, &block)
      routes[:get][path] = { handler: block, layout: args[:layout] }
    end

    def self.post(path, args={}, &block)
      routes[:post][path] = { handler: block, layout: args[:layout] }
    end

    def self.put(path, args={}, &block)
      routes[:put][path] = { handler: block, layout: args[:layout] }
    end

    def self.patch(path, args={}, &block)
      routes[:patch][path] = { handler: block, layout: args[:layout] }
    end

    def self.delete(path, args={}, &block)
      routes[:delete][path] = { handler: block, layout: args[:layout] }
    end

    def self.routes
      @routes ||= { get: {}, post: {}, put: {}, patch: {}, delete: {} }
    end

    def self.layouts
      @layouts ||= {}
    end

    def self.port(port_number=nil)
      @port = port_number if port_number
      @port || 8080
    end

    def self.layout(name=:main, &block)
      layouts[name] = block
    end

    def self.content(name=:main)
      "%CONTENT-#{name}%"
    end

  end
end
