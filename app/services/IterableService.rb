class IterableService
  include HTTParty
  
  base_uri 'https://api.iterable.com/api'
  headers 'Api-Key' => Rails.application.credentials.iterable_service.api_key

  class << self
    def create_user(user_id, email, name)
      response = post(
        '/users/update',
        body: { 
          email: email, 
          dataFields: { 
            userId: user_id,
            name: name
          } 
        }, 
        headers: { 'Content-Type' => 'application/json' }
      )

      if response.success?
        return {success: true}
      else
        return {success: false, error: response.body}
      end
    end

    def create_event(event_type, user_id)
      response = post(
        '/events/track', 
        body: { 
          eventType: event_type, 
          user: { userId: user_id } 
        }, 
        headers: { 'Content-Type' => 'application/json' }
      )
      if response.success?
        return {success: true}
      else
        return {success: false, error: response.body}
      end
    end

    def send_email_notification(user_email)
      response = post(
        '/email/target',
        body: {
          campaignId: 0,
          recipientEmail: user_email
        }, 
        headers: { 'Content-Type' => 'application/json' }
      )

      if response.success?
        return {success: true}
      else
        return {success: false, error: response.body}
      end
    end
  end
end
