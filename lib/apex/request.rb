module Apex
  class Request
    attr_accessor :raw

    def initialize(raw)
      @raw = raw
    end

    def body?
      raw.hasBody
    end

    def content_type
      raw.contentType
    end

    def content_length
      raw.contentLength
    end
    alias_method :length, :content_length

    def query
      raw.query
    end

    def path
      raw.path
    end

    def url
      raw.URL
    end

    def url_string
      url.absoluteString
    end

  end
end
