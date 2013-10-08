require "rest-client"
require 'multi_json'
require 'uri'


module Elong
  # Elong Http Request Class
  class Request
    attr_reader :user, :appKey, :secretKey
    attr_accessor :data, :timestamp, :signature, :format, :domain, :version, :local, :https

    # Initializes a Request instance
    #
    # @param [String] user the user value
    # @param [String] appKey the appKey value
    # @param [String] secretKey the secretKey value
    # @param opts [String] :domain elong api url (default: 'http://api.elong.com/rest')
    # @param opts [String] :version the version of elong api version (default: '1.0')
    # @param opts [String] :local the data return language (ONLY 'en_US' and 'zn_CN', default: 'zh_CN')
    # @param opts [String] :format the data return foramat (ONLY 'json' and 'xml', default: 'json')
    # @return [Elong::Request]
    def initialize(user, appKey, secretKey, opts={})
      @user = user
      @appKey = appKey
      @secretKey = secretKey

      @https = false
      @domain = opts[:version] ? opts[:version] : 'http://api.elong.com/rest'
      @version = opts[:version] ? opts[:version] : '1.0'
      @local = opts[:local] ? opts[:local] : 'zh_CN'
      @format = opts[:format] ? opts[:format] : 'json'
    end

    # Create a http request to call api
    #
    # @param [String] api call section api(eg, hotel.list, hotel.detail)
    # @param [Hash] data the data request for api
    # @param [Boolean] https request url if https or http (default: nil)
    # @return [Elong::Response]
    def execute(api, data, https=nil)
      self.generateTimestamp
      self.buildData(data)
      self.generateSignature

      params = self.buildQueryParams(api)
      uri = URI.parse(@domain)
      https = @https if ![TrueClass, FalseClass].include?(https.class)
      scheme = https ? 'https' : 'http'
      url = "#{scheme}://#{uri.host}/#{uri.path}?#{params}"

      response = Elong::Response.new(RestClient.get(url))
    end

    # Build and format query params for url request
    #
    # @return [String]
    def buildQueryParams(api)
      URI.encode_www_form([
        ["method", api],
        ["user", @user],
        ["timestamp", @timestamp],
        ["data", @data],
        ["signature", @signature],
        ["format", @format],
     ]).to_s
    end

    # Build request params
    #
    # @return [Hash]
    def buildData(params)
      @data = MultiJson.dump({
        'Version' => @version,
        'Local'   => @local,
        'Request' => params
      })
    end

    # Generate a new timestamp
    #
    # @return [String]
    def generateTimestamp
      @timestamp = Time.now.to_i.to_s
    end

    # Generate a new signature
    #
    # @return [String]
    def generateSignature
      @timestamp ||= self.generateTimestamps
      @signature = Digest::MD5.hexdigest(@timestamp + Digest::MD5.hexdigest(@data + @appKey).downcase + @secretKey).downcase
    end
  end
end
