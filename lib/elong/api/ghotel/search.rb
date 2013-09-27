module Elong
  module API
    module GHotel
      class Search < Elong::API::Base
        def initialize(client)
          @client = client
        end
      end
    end
  end
end
