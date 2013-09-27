require 'spec_helper'


describe Elong::Client do
  subject { @client }

  describe '#初始化' do
    it '应该允许 client 被实例化' do
      subject.should be_instance_of Elong::Client
    end

    it '应该允许 request 被实例化' do
      subject.request.should_not be_nil
      subject.request.should be_instance_of Elong::Request
    end
  end

  describe '#调用方法' do
    context '执行 hotel 方法' do
      let(:hotel) { subject.hotel }
      it "必须继承自 Elong::API::Hotel" do
        hotel.should be_instance_of Elong::API::Hotel::Core
      end
    end

    context '执行 ghotel 方法' do
      let(:ghotel) { subject.ghotel }
      it "必须继承自 Elong::API::GHotel" do
        ghotel.should be_instance_of Elong::API::GHotel::Core
      end
    end

    context '执行 common 方法' do
      let(:common) { subject.common }
      it "必须继承自 Elong::API::Common" do
        common.should be_instance_of Elong::API::Common::Core
      end
    end
  end
end
