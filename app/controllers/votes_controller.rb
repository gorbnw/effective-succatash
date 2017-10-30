class VotesController < ApplicationController

  def create
    @vote = Vote.new(user_id: current_user.id, testimonial_id: params[:vote][:testimonial_id])
    @vote.save!
    testimonial = Testimonial.find(params[:vote][:testimonial_id])
    if request.xhr?
      render :json => testimonial.votes.count.to_json
    else
      redirect_to "/businesses/#{testimonial.yelp_id}"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:testimonial_id)
  end
end
