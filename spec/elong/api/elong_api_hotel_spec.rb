require 'spec_helper'


describe Elong::API::Hotel do
  subject { @client.hotel }

  describe 'GET #detail' do
    it '可以获取正确的房源信息' do
      @client.request.format = 'json'
      res = subject.detail(HotelIds:@hotelId,
                           ArrivalDate:@tomorrow,
                           DepartureDate:@theDayAfterTomorrow)

      res.status.should eq(200)
      res.code.should eq('0')
      res.error.should be_nil

      res.should be_json
      #res.to_json['Result']['']
    end

    it '允许获取的结果为空' do
      @client.request.format = 'json'
      res = subject.detail(HotelIds:'999999999999999999',
                           ArrivalDate:@tomorrow,
                           DepartureDate:@theDayAfterTomorrow)

      res.status.should eq(200)
      res.code.should eq('0')
      res.error.should be_nil

      res.should be_json
      res.to_json['Result']['Count'].should eq(0)
    end

    it '允许获取不存在的房源信息' do
      @client.request.format = 'json'
      res = subject.detail(HotelIds:'ddddd',
                           ArrivalDate:@tomorrow,
                           DepartureDate:@theDayAfterTomorrow)

      res.status.should eq(200)
      res.code.should eq('H000008')
      res.error.should match('Ids不符合数字逗号格式')
    end

    it '必须保证时间格式正确无误' do
      @client.request.format = 'json'
      res = subject.detail(HotelIds:'000000',
                           ArrivalDate:'13-10-1',
                           DepartureDate:'13/10/2')

      res.status.should eq(200)
      res.code.should eq('H000998')
      res.error.should match('请求参数异常')
    end
  end

  describe 'GET #list' do
    it '可以设置返回的房源数量' do
      @client.request.format = 'json'
      pageSize = 1
      #res = subject.list({'CityId' => @cityId,
      #                    'ArrivalDate' => @tomorrow,
      #                    'DepartureDate' => @theDayAfterTomorrow,
      #                    'PageSize' => pageSize})

      res = subject.list(CityId: @cityId,
                          ArrivalDate: @tomorrow,
                          DepartureDate: @theDayAfterTomorrow,
                          PageSize: pageSize)


      res.status.should eq(200)
      res.code.should eq('0')
      res.error.should be_nil

      res.should be_json

      #@todo: 貌似是bug，返回总是 20 个
      res.to_json['Result']['Hotels'].size.should eq(pageSize)
    end

    it '获取不存在的房源信息' do
      pending
    end
  end

  describe '#data' do
    describe 'GET data.rp' do
      it '获取正常数据' do
        pending
      end
    end
  end
end
