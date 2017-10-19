class EventsController < ApplicationController
    before_action :require_login
    def index
        @instate_events = Event.where(state:current_user.state)
        @outstate_events = Event.where.not(state:current_user.state)
    end

    def create
        @new_event = Event.new(event_params)
        if @new_event.save
            redirect_to "/events"
        else
            flash[:errors] = @new_event.errors.full_messages
            redirect_to "/events"
        end
    end

    def show
        @event = Event.find(params[:id])
        @attend_users = @event.attend_users
        @comments = @event.comments.order(id: :desc)
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        if @event.update(update_params)
            redirect_to "/events"
        else
            flash[:errors] = @event.errors.full_messages
            redirect_to "/events/#{params[:id]}/edit"
        end
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to "/events"
    end

    private
    def event_params
        params.require(:event).permit(:name, :date, :city, :state).merge(user:current_user)
    end

    def update_params
        params.require(:event).permit(:name, :date, :city, :state)
    end
end
