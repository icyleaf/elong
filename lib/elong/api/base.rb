module Elong
  module API
    # Elong API Base Class
    class Base

      # Initializes a API Base instance
      #
      # @params [Elong::Client] client an instance of Elong::Client
      # @return [ELong::API::Base]
      def initialize(client)
        @client = client
      end

      # Start a new http request
      #
      # @params [String] method the method of called in the instance class
      # @params [Hash] params the params of called api
      # @return [Elong::Response]
      def request(method, params)
        @client.request.execute(self.buildAPI(method), params)
      end

      # Build api url with class & methods
      #
      # @params [String] method the method of called in the instance class
      # @return [String]
      def buildAPI(method)
        className = self.class.name.split('::').map{|n|
          n.downcase if ! ['elong', 'api', 'core'].include?n.downcase
        }.compact.reject{|r| r.empty? if r.class == String}.join('.')
        methodName = method.downcase
        return "#{className}.#{methodName}"
      end
    end
  end
end
