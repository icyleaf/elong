module Elong
  module API
    module Hotel
      class Core < Elong::API::Base

        def list(params={})
          self.request(__method__, params)
        end

        def details(params={})
          self.request(__method__, params)
        end

        def data
          @data ||= Elong::API::Hotel::Data.new(@client)
        end

        def order
          @order ||= Elong::API::Hotel::Order.new(@client)
        end

        def incr
          @incr ||= Elong::API::Hotel::Incr.new(@client)
        end

      end
    end
  end
end
