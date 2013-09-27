require 'multi_json'
require 'multi_xml'


module Elong
  # Elong Http Response Class
  class Response
    attr_reader :status, :body, :headers, :cookies, :code, :error, :dataset

    # Initializes a Request instance
    #
    # @param [RestClient::Response]
    # @return [Elong::Response]
    def initialize(response)
      @status = response.code
      @body = response.to_str
      @headers = response.headers
      @cookies = response.cookies

      # mark status
      if @status == 200
        if self.json?
          content = self.to_json
          @code = content['Code']
          @dataset = content['Request']
        elsif self.xml?
          content = self.to_xml
          @code = content['ApiResult']['Code']
          @dataset = content['ApiResult']['Result']
        end

        @code, @error = @code.split('|') if @code and @code.include?'|'
        @code = @code
      end
    end

    # Whether or not the content is json content type
    #
    # @return [Boolean]
    def json?
      (@headers[:content_type].include?'json') ? true : false
    end

    # Whether or not the content is xml content type
    #
    # @return [Boolean]
    def xml?
      (['xml', 'html'].any? { |word| @headers[:content_type].include?(word) }) ? true : false
    end

    # Output response content
    #
    # @return [String]
    def to_s
      @body
    end

    # Convert response content to JSON format
    #
    # @return [Hash]
    def to_json
      MultiJson.load(@body)
    end

    # Convert response content to XML format
    #
    # @return [Hash]
    def to_xml(parser=nil)
      MultiXml.parser = p if parser and [:ox, :libxml, :nokogiri, :rexml].include?parser.to_sym
      MultiXml.parse(@body)
    end

  end
end
