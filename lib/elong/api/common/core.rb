module Elong
  module API
    module Common
      # Elong Common Core API Class
      class Core < Elong::API::Base

        # The Creditcard seciont
        #
        # @return [Elong::API::Common::Creditcard]
        def creditcard
          @creditcard ||= Elong::API::Common::Creditcard.new(@client)
        end

      end
    end
  end
end
