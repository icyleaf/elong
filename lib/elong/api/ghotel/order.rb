module Elong
  module API
    module GHotel
      # Elong Global Hotel Order API Class
      class Order < Elong::API::Base

        # The Global Hotel List Order API
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def list(params={})
          self.request(__method__, params)
        end

        # The Hotel Order Detail API
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def detail(params={})
          self.request(__method__, params)
        end

        # The Hotel Create Order API
        #
        # @todo MUST `https` request
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def create(params={})
          self.request(__method__, params)
        end

        # The Hotel Cancel Order API
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def cancel(params={})
          self.request(__method__, params)
        end


        # The Hotel Update Order API
        # ** Its not works in Hongkong, Macao, Taiwan **
        #
        # @params [Hash] params api params
        # @return [Elong::Response]
        def update(params={})
          self.request(__method__, params)
        end

      end
    end
  end
end
