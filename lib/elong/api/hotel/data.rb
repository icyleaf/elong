module Elong
  module API
    module Hotel
      # Elong Hotel Data API Class
      class Data < Elong::API::Base

        # The Hotel Data RP API
        # ** Adadvanced API Level **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def rp(params={})
          self.request(__method__, params)
        end

        # The Hotel Data Inventory API
        # ** Adadvanced API Level **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def inventory(params={})
          self.request(__method__, params)
        end

        # The Hotel Data Rate API
        # ** Adadvanced API Level **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def rate(params={})
          self.request(__method__, params)
        end

        # The Hotel Data Validate API
        # ** Adadvanced API Level **
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
