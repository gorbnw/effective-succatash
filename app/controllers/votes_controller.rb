class VotesController < ApplicationController
  def create
    @vote = Vote.new(user_id: current_user.id, testimonial_id: params[:vote][:testimonial_id])
    @vote.save!
    @business = Testimonial.find(params[:vote][:testimonial_id]).business
    redirect_to business_path(@business)
  end

  private

  def vote_params
    params.require(:vote).permit(:testimonial_id)
  end
end
