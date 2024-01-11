require 'rails_helper'
require 'webmock/rspec'

RSpec.describe IterableService, type: :service do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe '#create_user' do
    it 'sends a request to create a user in Iterable' do
      user_id = 123
      email = 'user@example.com'
      name = 'John Doe'

      stub_request(:post, /api.iterable.com\/api\/users\/update/).to_return(status: 200, body: '{"success": true}')

      response = IterableService.create_user(user_id, email, name)

      expect(response[:success]).to be(true)
    end

    it 'handles a failed request to create a user in Iterable' do
      user_id = 123
      email = 'user@example.com'
      name = 'John Doe'

      stub_request(:post, /api.iterable.com\/api\/users\/update/).to_return(status: 500, body: '{"error": "Server error"}')

      response = IterableService.create_user(user_id, email, name)
      expect(response[:success]).to be(false)
      expect(JSON.parse(response[:error])['error']).to eq('Server error')
    end
  end

  describe '#create_event' do
    it 'sends a request to create an event in Iterable' do
      event_type = 'EventA'
      user_id = 123

      stub_request(:post, /api.iterable.com\/api\/events\/track/).to_return(status: 200, body: '{"success": true}')

      response = IterableService.create_event(event_type, user_id)

      expect(response[:success]).to be(true)
    end

    it 'handles a failed request to create an event in Iterable' do
      event_type = 'EventA'
      user_id = 123

      stub_request(:post, /api.iterable.com\/api\/events\/track/).to_return(status: 500, body: '{"error": "Server error"}')

      response = IterableService.create_event(event_type, user_id)

      expect(response[:success]).to be(false)
      expect(JSON.parse(response[:error])['error']).to eq('Server error')
    end
  end

  describe '#send_email_notification' do
    it 'sends a request to send an email notification in Iterable' do
      user_email = 'user@example.com'

      stub_request(:post, /api.iterable.com\/api\/email\/target/).to_return(status: 200, body: '{"success": true}')

      response = IterableService.send_email_notification(user_email)

      expect(response[:success]).to be(true)
    end

    it 'handles a failed request to send an email notification in Iterable' do
      user_email = 'user@example.com'

      stub_request(:post, /api.iterable.com\/api\/email\/target/).to_return(status: 500, body: '{"error": "Server error"}')

      response = IterableService.send_email_notification(user_email)

      expect(response[:success]).to be(false)
      expect(JSON.parse(response[:error])['error']).to eq('Server error')
    end
  end
end
