require 'spec_helper'

describe Elong::Request do
  let(:request) do
    user      = ""
    appKey    = ""
    secretKey = ""

    Elong::Request.new(user, appKey, secretKey)
  end

  describe "#初始化" do
    it 'user 不能为空' do
      request.user.should_not be_nil
      request.user.should_not be_empty
    end

    it 'appKey 不能为空' do
      request.appKey.should_not be_nil
      request.appKey.should_not be_empty
    end

    it 'secretKey 不能为空' do
      request.secretKey.should_not be_nil
      request.secretKey.should_not be_empty
    end

    it 'domain 不能为空' do
      request.domain.should_not be_nil
      request.domain.should_not be_empty
    end

    it 'version 不能为空' do
      request.version.should_not be_nil
      request.version.should_not be_empty
    end

    it 'local 不能为空' do
      request.local.should_not be_nil
      request.local.should_not be_empty
    end

    it 'format 不能为空' do
      request.format.should_not be_nil
      request.format.should_not be_empty
    end
  end


  describe "#验证" do
    it '允许修改 version 的值' do
      request.version = '1.0'
      request.version.should eq('1.0')

      request.version = '1.1'
      request.version.should eq('1.1')

      request.version = '2.0'
      request.version.should eq('2.0')
    end

    it '允许修改 local 的值' do
      request.local = '0'
      request.local.should eq('0')

      request.local = '1'
      request.local.should eq('1')

      request.local = '2'
      request.local.should eq('2')
    end

    it 'format 必须是 xml 或 json' do
      request.format.should match(/(json|xml)/i)
    end

    it '允许修改 format 的值' do
      request.format = 'xml'
      request.format.should eq('xml')

      request.format = 'json'
      request.format.should eq('json')

      request.format = 'rss'
      request.format.should eq('rss')
    end

    it '生成 timestamp 的值随当前系统时间' do
      timestamp1 = request.generateTimestamp
      request.timestamp.should eq(timestamp1)

      sleep(1)

      timestamp2 = request.generateTimestamp
      request.timestamp.should eq(timestamp2)

      timestamp2.to_i.should > timestamp1.to_i
    end

    it '查看 data 数据是否吻合' do
      data = {
        'HotelIds' => '42407063',
        'ArrivalDate' => '2013-09-25',
        'DepartureDate' => '2013-09-26',
      }
      jsonData = request.buildData(data)
      parsedData = JSON.parse(jsonData)

      parsedData.should have_key('Version')
      parsedData['Version'].should eq(request.version)

      parsedData.should have_key('Local')
      parsedData['Local'].should eq(request.local)

      parsedData.should have_key('Request')
      parsedData.should have(data.size).Request
      parsedData['Request']['HotelIds'].should eq('42407063')
      parsedData['Request']['ArrivalDate'].should eq('2013-09-25')
      parsedData['Request']['DepartureDate'].should eq('2013-09-26')
    end

  end
end
