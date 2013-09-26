require 'spec_helper'


describe Elong::Request do
  subject { @client.request }

  let(:departure_date) { Time.now }
  let(:sample_api) {'hotel.list'}
  let(:sample_data) do
    params = {
      'CityId' => @cityId,
      'ArrivalDate' => @tomorrow,
      'DepartureDate' => @theDayAfterTomorrow,
      'PageSize' => 1
    }
  end

  context '#初始化' do
    it 'user 不能为空' do
      subject.user.should_not be_nil
      subject.user.should_not be_empty
      subject.user.should eq @user
    end

    it 'appKey 不能为空' do
      subject.appKey.should_not be_nil
      subject.appKey.should_not be_empty
      subject.appKey.should eq @appKey
    end

    it 'secretKey 不能为空' do
      subject.secretKey.should_not be_nil
      subject.secretKey.should_not be_empty
      subject.secretKey.should eq @secretKey
    end

    it 'domain 不能为空' do
      subject.domain.should_not be_nil
      subject.domain.should_not be_empty
    end

    it 'version 不能为空' do
      subject.version.should_not be_nil
      subject.version.should_not be_empty
    end

    it 'local 不能为空' do
      subject.local.should_not be_nil
      subject.local.should_not be_empty
    end

    it 'format 不能为空' do
      subject.format.should_not be_nil
      subject.format.should_not be_empty
    end

    it 'timestamp 默认为空' do
      subject.timestamp.should be_nil
    end

    it 'signature 默认为空' do
      subject.signature.should be_nil
    end

    it 'data 默认为空' do
      subject.data.should be_nil
    end
  end

  context '#验证数据' do
    it '允许修改 version 的值' do
      subject.version = '1.0'
      subject.version.should eq('1.0')

      subject.version = '1.1'
      subject.version.should eq('1.1')

      subject.version = '2.0'
      subject.version.should eq('2.0')
    end

    it '允许修改 local 的值' do
      subject.local = '0'
      subject.local.should eq('0')

      subject.local = '1'
      subject.local.should eq('1')

      subject.local = '2'
      subject.local.should eq('2')
    end

    it 'format 必须是 xml 或 json' do
      subject.format.should match(/(json|xml)/i)
    end

    it '允许修改 format 的值' do
      subject.format = 'xml'
      subject.format.should eq('xml')

      subject.format = 'json'
      subject.format.should eq('json')

      subject.format = 'rss'
      subject.format.should eq('rss')
    end

    it '生成 timestamp 的值随当前系统时间' do
      timestamp1 = subject.generateTimestamp
      subject.timestamp.should eq(timestamp1)

      sleep(1)

      timestamp2 = subject.generateTimestamp
      subject.timestamp.should eq(timestamp2)

      timestamp2.to_i.should > timestamp1.to_i
    end

    it '查看 data 数据是否吻合' do
      jsonData = subject.buildData(sample_data)
      parsedData = JSON.parse(jsonData)

      parsedData.should have_key('Version')
      parsedData['Version'].should eq(subject.version)

      parsedData.should have_key('Local')
      parsedData['Local'].should eq(subject.local)

      parsedData.should have_key('Request')
      parsedData['Request'].size.should == sample_data.size
      parsedData['Request']['CityId'].should match(/\d+/i)
      parsedData['Request']['ArrivalDate'].should match(/\d{4}-\d{2}-\d{2}/i)
      parsedData['Request']['DepartureDate'].should match(/\d{4}-\d{2}-\d{2}/i)
    end

    it '查看生成的 signature 数据是否正确' do
      subject.generateTimestamp
      subject.buildData(sample_data)
      subject.generateSignature

      subject.signature.should_not be_nil
      subject.signature.should_not be_empty
      subject.signature.should have(32).characters
    end
  end

  context '#执行方法' do
    describe '.execute' do

      it '返回 200 状态码' do
        res = subject.execute(sample_api, sample_data)
        res.code.should eq(200)
      end

      it '返回 json 数据并解析' do
        subject.format = 'json'

        res = subject.execute(sample_api, sample_data)
        res.code.should eq(200)

        dataset = JSON.parse(res)
        dataset['Code'].should == '0'
        dataset['Result']['Count'].should >= 0
      end

      it '返回 xml 数据并解析' do
        pending

        #subject.format = 'xml'
        #res = subject.execute(sample_api, sample_data)
        #res.code.should eq(200)
        #
        #dataset = REXML::Document.new(res)
      end
    end
  end
end
