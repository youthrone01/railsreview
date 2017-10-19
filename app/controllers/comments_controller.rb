class CommentsController < ApplicationController
    before_action :require_login
    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            redirect_to "/events/#{params[:event_id]}"
        else
            flash[:errors] = @comment.errors.full_messages
            redirect_to "/events/#{params[:event_id]}"
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:event_id,:content).merge(user: current_user)
    end
end
