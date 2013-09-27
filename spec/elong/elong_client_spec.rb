require 'spec_helper'


describe Elong::Client do
  subject { @client }

  describe '#初始化' do
    it 'client 已经被实例化' do
      subject.should be_instance_of Elong::Client
    end

    it 'request 已经被实例化' do
      subject.request.should_not be_nil
      subject.request.should be_instance_of Elong::Request
    end
  end

  describe '#调用方法' do
    it "hotel 必须继承自 Elong::API::Hotel" do
      subject.hotel.should be_instance_of Elong::API::Hotel::Core
    end

    it "ghotel 必须继承自 Elong::API::GHotel" do
      subject.ghotel.should be_instance_of Elong::API::GHotel::Core
    end

    it "common 必须继承自 Elong::API::Common" do
      subject.common.should be_instance_of Elong::API::Common::Core
    end
  end
end
