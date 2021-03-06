class VotesController < ApplicationController
  before_action :require_user, only: [:create]

  def index
  end

  def create
    Vote.create!(value: params[:value], link_id: params[:link_id], user_id: current_user.id)
    redirect_to :back
  end

end
