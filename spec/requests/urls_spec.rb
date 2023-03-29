require 'rails_helper'

RSpec.describe UrlsController, type: :request do
  describe 'GET /urls/new' do
    it 'responds with a successful status code' do
      get '/urls/new'
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get '/urls/new'
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /:short' do
    let(:url) { Url.create(target: 'https://example.com', short: 'example') }

    it 'responds with a redirect status code' do
      get "/#{url.short}"
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to the target url' do
      get "/#{url.short}"
      expect(response).to redirect_to(url.target)
    end

    it 'redirects to the target url with allow_other_host option set to true' do
      get "/#{url.short}"
      expect(response).to redirect_to(url.target)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /urls' do
    context 'with valid parameters' do
      let(:params) do
        {
          url: {
            target: 'https://example.com',
          }
        }
      end

      it 'redirects to the created url' do
        post '/urls', params: params
        expect(response).to redirect_to(url_path(Url.last))
      end
    end

    context 'with invalid parameters' do
      let(:params) do
        {
          url: {
            target: nil
          }
        }
      end

      it 'renders the new template with errors' do
        post '/urls', params: params
        expect(response).to render_template(:new)
        expect(response.body).to include('Target can&#39;t be blank')
      end
    end
  end
end
