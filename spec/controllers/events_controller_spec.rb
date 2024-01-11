require 'rails_helper'
require 'webmock/rspec'

RSpec.describe EventsController, type: :controller do
  before do
   WebMock.disable_net_connect!(allow_localhost: true)
   stub_request(:post, /api.iterable.com\/api\/users\/update/).to_return(status: 200, body: '{"success": true}')
  end
  
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid event type' do
      it 'creates EventA and redirects' do
        stub_request(:post, /api.iterable.com\/api\/events\/track/).to_return(status: 200, body: '{"success": true}')
        post :create, params: { event_type: 'EventA' }
        
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event EventA created successfully')
      end

      it 'creates EventB, sends email, and redirects' do
        stub_request(:post, /api.iterable.com\/api\/events\/track/).to_return(status: 200, body: '{"success": true}')
        stub_request(:post, /api.iterable.com\/api\/email\/target/).to_return(status: 200, body: '{"success": true}')
        post :create, params: { event_type: 'EventB' }
        
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event EventB created successfully')
      end
    end

    context 'with invalid event type' do
      it 'redirects with an alert' do
        post :create, params: { event_type: 'InvalidEvent' }
        
        expect(response).to redirect_to(events_path)
        expect(flash[:alert]).to eq('Invalid event type')
      end
    end
  end
end
