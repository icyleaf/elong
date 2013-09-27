module Elong
  module API
    module GHotel
      class Core < Elong::API::Base

        def search
          @search ||= Elong::API::GHotel::Search.new(@client)
        end

        def order
          @order ||= Elong::API::GHotel::Order.new(@client)
        end

      end
    end
  end
end
