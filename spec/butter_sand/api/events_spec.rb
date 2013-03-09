# coding: utf-8
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

  describe 'on_sale' do
    before do
      @butter_sand = ButterSand::Client.new
      @butter_sand.instance_eval { @date_for_test = Date.parse('2013-03-14') }
    end

    subject { @butter_sand.on_sale }
    it { should have(1).item }
  end

  describe 'starts_today' do
    before do
      @butter_sand = ButterSand::Client.new
    end

    subject { @butter_sand.starts_today }

    context 'with no corresponding event' do
      before do
        @butter_sand.instance_eval { @date_for_test = Date.parse('2012-12-31') }
      end

      it { should have(0).item }
    end

    context 'with some corresponding events' do
      before do
        @butter_sand.instance_eval { @date_for_test = Date.parse('2013-01-15') }
      end

      it { should have(1).item }
    end
  end

  describe 'ends_today' do
    before do
      @butter_sand = ButterSand::Client.new
    end

    subject { @butter_sand.ends_today }

    context 'with no corresponding event' do
      before do
        @butter_sand.instance_eval { @date_for_test = Date.parse('2013-01-01') }
      end

      it { should have(0).item }
    end

    context 'with some corresponding events' do
      before do
        @butter_sand.instance_eval { @date_for_test = Date.parse('2013-02-28') }
      end

      it { should have(1).item }
    end
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