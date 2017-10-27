class VotesController < ApplicationController
  def create
    @vote = Vote.new(user_id: current_user.id, testimonial_id: params[:testimonial_id])
  end
end
