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
      #subject.appKey.should eq @appKey
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
      subject.local = 'en_US'
      subject.local.should eq('en_US')

      subject.local = 'zh_CN'
      subject.local.should eq('zh_CN')
    end

    it '允许 format 的值是 xml 或 json' do
      subject.format.should match(/(json|xml)/i)
    end

    it '可以修改 format 的值' do
      subject.format = 'xml'
      subject.format.should eq('xml')

      subject.format = 'rss'
      subject.format.should eq('rss')

      subject.format = 'json'
      subject.format.should eq('json')
    end

    it '可以修改 https 的值' do
      subject.https = true
      subject.https.should be_true

      subject.https = false
      subject.https.should be_false
    end

    it '可以生成 timestamp 的值' do
      timestamp1 = subject.generateTimestamp
      subject.timestamp.should eq(timestamp1)

      sleep(1)

      timestamp2 = subject.generateTimestamp
      subject.timestamp.should eq(timestamp2)

      timestamp2.to_i.should > timestamp1.to_i
    end

    it '必须与 data 数据吻合' do
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

    it '可以正常生成 signature 数据' do
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

      it '应该请求的 https 协议接口地址' do
        subject.https = true
        res = subject.execute(sample_api, sample_data)
        subject.https.should be_true

        res = subject.execute(sample_api, sample_data, https=true)
        subject.https.should be_true
      end

       it '应该请求的 http 协议接口地址' do
        subject.https = false
        res = subject.execute(sample_api, sample_data)
        subject.https.should be_false

        res = subject.execute(sample_api, sample_data, https=false)
        subject.https.should be_false
      end

      it '应该返回 200 状态码' do
        res = subject.execute(sample_api, sample_data)
        res.status.should eq(200)
      end

      it '应该返回 200 状态码' do
        res = subject.execute(sample_api, sample_data)
        res.status.should eq(200)
      end

      it '应该返回 json 数据并正常解析' do
        subject.format = 'json'

        res = subject.execute(sample_api, sample_data)
        res.status.should eq(200)

        res.should be_json
        res.code.should_not be_empty
      end

      it '应该能够返回 xml 数据并正常解析' do
        subject.format = 'xml'
        res = subject.execute(sample_api, sample_data)
        res.status.should eq(200)

        res.should be_xml
        res.code.should_not be_empty
      end
    end
  end
end
