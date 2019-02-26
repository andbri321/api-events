class Api::V1::EventsController < Api::V1::ApiController
 before_action :set_event, only: [:show, :update, :destroy]
 before_action :require_authorization!, only: [:show, :update, :destroy]

 # GET /api/v1/events
 def index
   @events = current_user.events
   render json: @events
 end

 # GET /api/v1/events/1
 def show
   render json: @event
 end

 # POST /api/v1/events
 def create
   @event = Event.new(event_params.merge(user: current_user))
   if @event.save
     render json: @event, status: :created
   else
     render json: @event.errors, status: :unprocessable_entity
   end
 end

 private

   def set_event
     @event = Event.find(params[:id])
   end

   def event_params
     params.require(:event).permit(:action)
   end

   def require_authorization!
     unless current_user == @event.user
       render json: {}, status: :forbidden
     end
   end

end
