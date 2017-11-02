class VotesController < ApplicationController

  def create
    if user_signed_in?
      @vote = Vote.find_by(user_id: current_user.id, testimonial_id: params[:vote][:testimonial_id])
      if @vote
        @vote.destroy
      else
        @vote = Vote.create(user_id: current_user.id, testimonial_id: params[:vote][:testimonial_id])
      end
      testimonial = Testimonial.find(params[:vote][:testimonial_id])
      if request.xhr?
        render :json => testimonial.votes.count.to_json
      else
        redirect_to "/businesses/#{testimonial.yelp_id}"
      end
    else
      if request.xhr?
        render :json => "Must login!", :status => 401
      end
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:testimonial_id)
  end
end
