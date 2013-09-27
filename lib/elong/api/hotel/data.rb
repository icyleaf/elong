module Elong
  module API
    module Hotel
      # Elong Hotel Data API Class
      class Data < Elong::API::Base

        def rp(params={})
          self.request(__method__, params)
        end
      end
    end
  end
end
