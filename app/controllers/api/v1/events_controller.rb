class Api::V1::EventsController < Api::V1::ApiController
  before_action :set_event, only: [:show, :search]
  before_action :require_authorization!, only: [:show, :search]

 # GET /api/v1/events
 def index
   @events = current_user.events
   render json: @events
 end

 # GET /api/v1/events/1
 def search
   @events = current_user.events.where(issue: params[:issue])
   render json: @events
 end

 # POST /api/v1/events
 def create
     @event = Event.new(action: params[:event][:action],issue: params[:issue][:number],title: params[:issue][:title],body: params[:issue][:body],user: current_user)
     if @event.save
       render json: @event, status: :created
     else
       render json: @event.errors, status: :unprocessable_entity
     end
 end

 private

   def set_event
    @event = current_user.events.where(issue: params[:issue]).first
    if @event.blank?
      render json: {}
    end
   end

   # def event_params
   #   params.require(:event).permit(:action)
   # end

   def require_authorization!
     unless current_user == @event.user
       render json: {}, status: :forbidden
     end
   end

end
