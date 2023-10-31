class RentalHistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @rental_histories = current_user.admin? ? RentalHistory.page(params[:page]) : current_user.rental_histories.page(params[:page])
  end
end