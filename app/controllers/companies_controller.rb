class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def new
    flash[:alert] = "You must create a company to continue."
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      current_user.company_id = @company.id
      if current_user.save
        flash[:success] = "Company Added Successfully"
        redirect_to user_taxis_path(current_user)
      end
    else
      render 'new'
    end
  end

  def edit
    @company = Company.find_by(id: current_user.company.id)
  end

  def update
    @company = Company.find_by(id: current_user.company.id)
    if @company.update_attributes(company_params)
      flash[:success] = "Company Updated Successfully"
      redirect_to user_taxis_path(current_user)
    else
      render 'edit'
    end
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
