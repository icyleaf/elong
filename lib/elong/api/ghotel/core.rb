module Elong
  module API
    module GHotel
      # Elong Global Hotel Core API Class
      class Core < Elong::API::Base

        # The Global Hotel Search section
        #
        # @return [Elong::API::GHotel::Search]
        def search
          @search ||= Elong::API::GHotel::Search.new(@client)
        end

        # The Global Hotel Order section
        #
        # @return [Elong::API::GHotel::Order]
        def order
          @order ||= Elong::API::GHotel::Order.new(@client)
        end

      end
    end
  end
end
