class TaxisController < ApplicationController
  before_action :set_user

  def new
    @taxi = Taxi.new
  end

  def create
    @taxi = Taxi.new(taxi_params)
    @taxi.user_id = @user.id
    Taxi.set_taxi_id(Taxi::IDLIST, @taxi)
    if @taxi.save
      flash[:success] = "Taxi Added Successfully"
      redirect_to user_taxis_path(@user.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
    @taxi = Taxi.find(params[:id])
    @answers = Answer.where(taxi_id: @taxi.id).load
  end

  def index
    @taxis = @user.taxis.all
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    def taxi_params
      params.require(:taxi).permit(:driver_first_name, :driver_last_name, :driver_id)
    end
end
