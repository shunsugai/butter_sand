require 'spec_helper'

describe ButterSand::Client do
  url = 'https://www.rokkatei-eshop.com/contents/shop/saiji/'
  path_saiji = '/contents/shop/saiji/'

  describe 'get' do
    context '400' do
      before do
        stub_request(:get, url).to_return(:status => 400, :body => {'error' => 'Bad Request'})
      end

      it 'should raise ButterSand::BadRequest' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::BadRequest
      end
    end

    context '401' do
      before do
        stub_request(:get, url).to_return(:status => 401, :body => {'error' => 'Unauthorized'})
      end

      it 'should raise ButterSand::Unauthorized' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::Unauthorized
      end
    end

    context '403' do
      before do
        stub_request(:get, url).to_return(:status => 403, :body => {'error' => 'Forbidden'})
      end

      it 'should raise ButterSand::Unauthorized' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::Forbidden
      end
    end

    context '404' do
      before do
        stub_request(:get, url).to_return(:status => 404, :body => {'error' => 'Not Found'})
      end

      it 'should raise ButterSand::NotFound' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::NotFound
      end
    end

    context '406' do
      before do
        stub_request(:get, url).to_return(:status => 406, :body => {'error' => 'Not Acceptable'})
      end

      it 'should raise ButterSand::NotAcceptable' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::NotAcceptable
      end
    end

    context '500' do
      before do
        stub_request(:get, url).to_return(:status => 500, :body => {'error' => 'Internal Server Error'})
      end

      it 'should raise ButterSand::InternalServerError' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::InternalServerError
      end
    end

    context '503' do
      before do
        stub_request(:get, url).to_return(:status => 503, :body => {'error' => 'Internal Server Error'})
      end

      it 'should raise ButterSand::ServiceUnavailable' do
        lambda{ ButterSand.get(path_saiji) }.should raise_error ButterSand::ServiceUnavailable
      end
    end
  end
end