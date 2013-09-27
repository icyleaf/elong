module Elong
  module API
    module Common
      class Creditcard < Elong::API::Base
        def initialize(client)
          @client = client
        end
      end
    end
  end
end
