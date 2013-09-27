module Elong
  module API
    module Common
      class Core < Elong::API::Base

        def creditcard
          @creditcard ||= Elong::API::Common::Creditcard.new(@client)
        end

      end
    end
  end
end
