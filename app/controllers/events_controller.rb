class EventsController < ApplicationController
  before_action :authenticate_user!
  
  def index; end	

  def create
    event_type = params[:event_type]
    
    return redirect_to events_path, alert: 'Invalid event type' unless valid_event_type?(event_type)

    response = IterableService.create_event(event_type, current_user.id)

    if response[:success]
      case event_type
      when 'EventB'
        IterableService.send_email_notification(current_user.email) 
      end

      redirect_to events_path, notice: "Event #{event_type} created successfully"
    else
      redirect_to events_path, alert: "Unable to create event with following error: #{response[:error]}"
    end
  end

  private

  def valid_event_type?(event_type)
    event_type.present? && event_type.in?(['EventA', 'EventB'])
  end
end
