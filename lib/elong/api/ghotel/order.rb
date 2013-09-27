module Elong
  module API
    module GHotel
      class Order < Elong::API::Base
        def initialize(client)
          @client = client
        end
      end
    end
  end
end
