class CommentsController < ApplicationController
  before_action :set_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      flash[:alert] = "Comment has not been created."
      @states=State.all # states has to be loaded again to be able to call render instead of redirect_to to be able to show error message in view
      render template: "tickets/show"
    end
    
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
  def comment_params
    if cannot?(:"change states", @ticket.project)
      params[:comment].delete(:state_id)
    end
    params.require(:comment).permit(:text, :tag_names, :state_id)
  end

end