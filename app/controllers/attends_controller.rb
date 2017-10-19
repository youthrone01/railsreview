class AttendsController < ApplicationController
    before_action :require_login
    
    def create
        Attend.create(user:current_user, event_id:params[:event_id])
        redirect_to "/events"
    end

    def destroy
        @attend = Attend.find(params[:id])
        @attend.destroy
        redirect_to "/events"
    end
end
