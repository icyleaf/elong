require 'spec_helper'


describe Elong::Response do
  let(:response) { @client.hotel.list(CityId:'0101', ArrivalDate:'', DepartureDate:'', PageSize:1) }
  describe '#初始化' do
    it '测试类的继承' do
      subject.should be_instance_of Elong::Response
    end

    it ''
  end


end
