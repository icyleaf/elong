module Elong
  module API
    module GHotel
      # Elong Global Hotel Search API Class
      class Search < Elong::API::Base

        # Search and list globalehotel data
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

        # Check hotel room status(type, available numbers)
        #
        # @return [Elong::Response]
        def room(params={})
          self.request(__method__, params)
        end

      end
    end
  end
end
