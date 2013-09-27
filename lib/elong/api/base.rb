module Elong
  module API
    class Base
      def initialize(client, options={})
        @client = client
      end

      def request(method, params)
        @client.request.execute(self.buildAPI(method), params)
      end

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
