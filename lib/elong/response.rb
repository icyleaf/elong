require 'multi_json'
require 'multi_xml'


module Elong
  class Response
    attr_reader :status, :body, :headers, :cookies, :code, :error, :dataset

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

        @code, @error = @code.split('|') if @code.include?'|'
        @code = @code
      end
    end

    def json?
      (@headers[:content_type].include?'json') ? true : false
    end

    def xml?
      (@headers[:content_type].include?'xml') ? true : false
    end

    def to_s
      @body
    end

    def to_json
      MultiJson.load(@body)
    end

    def to_xml
      MultiXml.parse(@body)
    end

  end
end
