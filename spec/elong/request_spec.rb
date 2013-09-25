require 'spec_helper'
require 'date'
require 'rexml/document'


describe Elong::Request do
  let(:request) do
    user = ''
    appKey = ''
    secretKey = ''

    Elong::Request.new(user, appKey, secretKey)
  end

  let(:departure_date) { Time.now}
  let(:sample_api) {'hotel.list'}
  let(:sample_data) do
    today = Time.now.to_i
    tomorrow = today + 24*3600
    next_week = today + 2*24*3600

    params = {
      'CityId' => '0101',
      'ArrivalDate' => DateTime.strptime(tomorrow.to_s, '%s').to_time.strftime('%Y-%m-%d'),
      'DepartureDate' => DateTime.strptime(next_week.to_s, '%s').to_time.strftime('%Y-%m-%d'),
      'PageSize' => 1
    }
  end

  context "#初始化" do
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

    it 'timestamp 默认为空' do
      request.timestamp.should be_nil
    end

    it 'signature 默认为空' do
      request.signature.should be_nil
    end

    it 'data 默认为空' do
      request.data.should be_nil
    end
  end

  context "#验证数据" do
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
      jsonData = request.buildData(sample_data)
      parsedData = JSON.parse(jsonData)

      parsedData.should have_key('Version')
      parsedData['Version'].should eq(request.version)

      parsedData.should have_key('Local')
      parsedData['Local'].should eq(request.local)

      parsedData.should have_key('Request')
      parsedData['Request'].size.should == sample_data.size
      parsedData['Request']['CityId'].should match(/\d+/i)
      parsedData['Request']['ArrivalDate'].should match(/\d{4}-\d{2}-\d{2}/i)
      parsedData['Request']['DepartureDate'].should match(/\d{4}-\d{2}-\d{2}/i)
    end

    it '查看生成的 signature 数据是否正确' do
      request.generateTimestamp
      request.buildData(sample_data)
      request.generateSignature

      request.signature.should_not be_nil
      request.signature.should_not be_empty
      request.signature.should have(32).characters
    end
  end

  context '#执行方法' do
    describe '.execute' do

      it "返回 200 状态码" do
        res = request.execute(sample_api, sample_data)
        res.code.should eq(200)
      end

      it "返回 json 数据并解析" do
        request.format = 'json'

        res = request.execute(sample_api, sample_data)
        res.code.should eq(200)

        dataset = JSON.parse(res)
        dataset['Code'].should == "0"
        dataset['Result']['Count'].should >= 0
      end

      it "返回 xml 数据并解析" do
        pending

        #request.format = 'xml'
        #res = request.execute(sample_api, sample_data)
        #res.code.should eq(200)
        #
        #dataset = REXML::Document.new(res)
      end
    end
  end
end
