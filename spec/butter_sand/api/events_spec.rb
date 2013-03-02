require 'spec_helper'

describe ButterSand::API::Events do
  url = 'https://www.rokkatei-eshop.com/contents/shop/saiji/'

  before do
    stub_request(:get, url).to_return(:status => 200, :body => fixture('marusei.html'))
  end

  describe 'all' do
    subject { ButterSand.all }
    it { should have(5).items }
  end

  describe 'find_by_prefecture' do
    it 'should have an item' do
      ButterSand.send(:find_by_prefecture, '東京').should have(1).item
    end

    it 'should include ButterSand::Event' do
      ButterSand.send(:find_by_prefecture, '東京').first.should be_kind_of ButterSand::Event
    end

    it 'should be empty array' do
      ButterSand.send(:find_by_prefecture, '山形').should be_empty
    end

    it 'should raise ArgumentError' do
      lambda{ ButterSand.send(:find_by_prefecture, 1111) }.should raise_error ArgumentError
    end
  end
end