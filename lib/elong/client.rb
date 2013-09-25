module Elong
  class Client
    attr_reader :request

    def initialize(user, appKey, secretKey, opt={})
      @request = Elong::Request.new(user, appKey, secretKey, opt)
    end
  end
end
