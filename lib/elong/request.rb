require "rest-client"
require 'uri'
require 'json'


module Elong
  class Request
    attr_reader :user, :appKey, :secretKey
    attr_accessor :data, :timestamp, :signature, :format, :domain, :version, :local

    def initialize(user, appKey, secretKey, opt={})
      @user = user
      @appKey = appKey
      @secretKey = secretKey

      @domain = opt[:version] ? opt[:version] : 'http://api.elong.com/rest'
      @version = opt[:version] ? opt[:version] : '1.0'
      @local = opt[:local] ? opt[:local] : '0'
      @format = opt[:format] ? opt[:format] : 'xml'
    end

    def execute(api, data)
      self.generateTimestamp
      self.buildData(data)
      self.generateSignature

      params = self.buildQueryParams(api)
      url = "#{domain}?#{params}"

      response = RestClient.get(url)
    end

    def buildQueryParams(api)
      URI.encode_www_form([
       ["user", @user],
       ["method", api],
       ["timestamp", @timestamp],
       ["format", @format],
       ["signature", @signature],
       ["data", self.buildData],
     ]).to_s
    end

    def buildData(params={})
      @data = JSON.dump({
        'Version' => @version,
        'Local' => @local,
        'Request' => params
      })
    end

    def generateTimestamp
      @timestamp = Time.now.to_i.to_s
    end

    def generateSignature
      @timestamp ||= self.generateTimestamps
      @signature = Digest::MD5.hexdigest(@timestamp + Digest::MD5.hexdigest(@data + @appKey).downcase + @secretKey).downcase
    end
  end
end
