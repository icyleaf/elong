module Elong
  module API
    module Common
      # Elong Creditcard of Common API Class
      class Creditcard < Elong::API::Base

        # Validate creditcard if or not the CVV must be input
        #
        # @todo MUST `https` request
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def validate(params={})
          self.request(__method__, params)
        end

      end
    end
  end
end
