module Elong
  module API
    module Hotel
      # Elong Hotel Core API Class
      class Core < Elong::API::Base

        # List hotel data for recent 90 days data.
        # the result will be cacahed about 10 mins
        #
        # @return [Elong::Response]
        def list(params={})
          self.request(__method__, params)
        end

        # View hotel details data
        #
        # @return [Elong::Response]
        def detail(params={})
          self.request(__method__, params)
        end

        # The Hotel Data section
        #
        # @return [Elong::API::Hotel::Data]
        def data
          @data ||= Elong::API::Hotel::Data.new(@client)
        end

        # The Hotel Order section
        #
        # @return [Elong::API::Hotel::Order]
        def order
          @order ||= Elong::API::Hotel::Order.new(@client)
        end

        # The Hotel Incr section
        #
        # @return [Elong::API::Hotel::Incr]
        def incr
          @incr ||= Elong::API::Hotel::Incr.new(@client)
        end

      end
    end
  end
end
