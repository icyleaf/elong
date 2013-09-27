module Elong
  module API
    module Hotel
      class Incr < Elong::API::Base
        def initialize(client)
          @client = client
        end
      end
    end
  end
end
