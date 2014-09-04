module Apex
  class Request
    HEADER_PARAM = /\s*[\w.]+=(?:[\w.]+|"(?:[^"\\]|\\.)*")?\s*/
    HEADER_VALUE_WITH_PARAMS = /(?:(?:\w+|\*)\/(?:\w+(?:\.|\-|\+)?|\*)*)\s*(?:;#{HEADER_PARAM})*/

    attr_accessor :raw, :route

    def initialize(raw)
      @raw = raw
    end

    def body?
      raw.hasBody
    end

    def content_type
      raw.contentType
    end

    def headers
      raw.headers
    end

    def content_length
      raw.contentLength
    end
    alias_method :length, :content_length

    def query
      raw.query
    end
    alias_method :params, :query

    def path
      raw.path
    end

    def url
      raw.URL
    end

    def method
      raw.method
    end

    def get?
      method == "GET"
    end

    def post?
      method == "POST"
    end

    def put?
      method == "PUT"
    end

    def patch?
      method == "PATCH"
    end

    def delete?
      method == "DELETE"
    end

  end
end
