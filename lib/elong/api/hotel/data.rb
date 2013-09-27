module Elong
  module API
    module Hotel
      class Data < Elong::API::Base
        def initialize(client)
          @client = client
        end

        def rp(params={})
          self.request(__method__, params)
        end
      end
    end
  end
end
