module Elong
  class Client
    attr_reader :request

    def initialize(user, appKey, secretKey, opt={})
      @request = Elong::Request.new(user, appKey, secretKey, opt)
    end

    def hotel
      @hotel ||= Elong::API::Hotel.new(self)
    end

    def ghotel
      @ghotel ||= Elong::API::GHotel.new(self)
    end

    def common
      @common ||= Elong::API::Common.new(self)
    end

  end
end
