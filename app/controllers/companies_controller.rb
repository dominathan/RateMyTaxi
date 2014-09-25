class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Company Added Successfully"
      redirect_to user_taxis_path(current_user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def company_params
      params.require(:company).permit(:name, :street_address, :city, :state, :zipcode,
                                      :contact_person, :phone_number, :email, :taxi_count)
    end

end
