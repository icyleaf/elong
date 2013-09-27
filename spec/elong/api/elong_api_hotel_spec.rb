require 'spec_helper'


describe Elong::API::Hotel do
  subject { @client.hotel }

  describe 'GET #detail' do
    it '获取正确的房源信息' do
      pending
    end

    it '获取不存在的房源信息' do
      pending
    end

    it '设置时间格式' do

    end
  end

  describe 'GET #list' do
    it '获取 3 条房源数量' do
      subject.list
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
