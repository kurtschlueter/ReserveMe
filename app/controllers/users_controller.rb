class UsersController < ApplicationController
  def show
    @current_user = current_user
    @reservations = current_user.reservations
  end
end
