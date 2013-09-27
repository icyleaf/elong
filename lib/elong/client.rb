module Elong
  # Elong Client Class
  class Client
    attr_reader :request

    # Instantiate a new Elong API client using the
    # user, appKey and secretKey registered to your
    # application
    #
    # @param [String] user the user value
    # @param [String] appKey the appKey value
    # @param [String] secretKey the secretKey value
    # @param opts [String] :domain elong api url (default: 'http://api.elong.com/rest')
    # @param opts [String] :version the version of elong api version (default: '1.0')
    # @param opts [String] :local the data return language (ONLY 'en_US' and 'zn_CN', default: 'zh_CN')
    # @param opts [String] :format the data return foramat (ONLY 'json' and 'xml', default: 'json')
    # @return [Elong::Client]
    def initialize(user, appKey, secretKey, opts={})
      @request = Elong::Request.new(user, appKey, secretKey, opts)
    end

    # The Hotel section
    #
    # @return [Elong::API::Hotel::Core]
    def hotel
      @hotel ||= Elong::API::Hotel::Core.new(self)
    end

    # The Globel Hotel section
    #
    # @return [Elong::API::GHotel::Core]
    def ghotel
      @ghotel ||= Elong::API::GHotel::Core.new(self)
    end

    # The Common section
    #
    # @return [Elong::API::Common::Core]
    def common
      @common ||= Elong::API::Common::Core.new(self)
    end

  end
end
