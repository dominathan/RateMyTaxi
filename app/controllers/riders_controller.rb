class RidersController < ApplicationController

  def new
    @rider = Rider.new
  end

  def create
    @rider = Rider.new(rider_params)
    if @rider.save
      flash[:success] = "Thank you!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def all_customers
    @riders = Rider.where(company_id: current_user.company_id)
  end

  private

    def rider_params
      params.require(:rider).permit(:name, :email, :phone_number, :company_id)
    end

end
