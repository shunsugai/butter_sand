require 'spec_helper'
require 'date'

describe ButterSand::Parser do
  path_saiji = '/contents/shop/saiji/'

  context 'with some events' do
    before do
      stub_request(:get, 'https://www.rokkatei-eshop.com/contents/shop/saiji/')
      .to_return(:status => 200, :body => fixture('marusei.html'))
      @response = ButterSand.get(path_saiji)
      @response_array = ButterSand::Parser.to_array(@response)
    end

    describe 'to_array' do
      it 'should be kind of Array' do
        @response_array.should be_kind_of Array
      end

      it 'should have 5 items' do
        @response_array.should have(5).items
      end

      it 'includes Hash' do
        @response_array.sample.should be_kind_of Hash
      end

      it "first item's shop name should be 'うすい百貨店'" do
        @response_array.first[:shop].should eq 'うすい百貨店'
      end

      it "first item's prefecture should be '福島'" do
        @response_array.first[:prefecture].should eq '福島'
      end

      it "first item's start date should be 2013-02-20" do
        @response_array.first[:starts].should eq Date.parse('2013-02-20')
      end

      it "first item's end date should be 2013-03-12" do
        @response_array.first[:ends].should eq Date.parse('2013-03-12')
      end

      it "first item's phone number should be 0249-32-0001" do
        @response_array.first[:phone].should eq '0249-32-0001'
      end
    end
  end

  context 'with no event' do
    before do
      stub_request(:get, 'https://www.rokkatei-eshop.com/contents/shop/saiji/')
      .to_return(:status => 200, :body => fixture('marusei_no_event.html'))
      @response = ButterSand.get(path_saiji)
      @response_array = ButterSand::Parser.to_array(@response)
    end

    describe 'to_hash' do
      it 'should be kind of Array' do
        @response_array.should be_kind_of Array
      end
      it 'should not have any items' do
        @response_array.should have(0).items
      end
    end
  end
end