module Elong
  module API
    module Hotel
      # Elong Hotel Incr API Class
      class Incr < Elong::API::Base

        # The Hotel Incr Id API
        # ** Adadvanced API Level **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def id(params={})
          self.request(__method__, params)
        end

        # The Hotel Incr Inv API
        # ** Adadvanced API Level **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def inv(params={})
          self.request(__method__, params)
        end

        # The Hotel Incr Rate API
        # ** Adadvanced API Level **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def rate(params={})
          self.request(__method__, params)
        end

        # The Hotel Incr Order API
        #
        # @todo MUST `https` request
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def order(params={})
          self.request(__method__, params)
        end

        # The Hotel Incr Feedback API
        #
        # @todo MUST `https` request
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def feedback(params={})
          self.request(__method__, params)
        end

      end
    end
  end
end
