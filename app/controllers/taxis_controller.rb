class TaxisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def new
    @taxi = Taxi.new
  end

  def create
    @taxi = Taxi.new(taxi_params)
    @taxi.user_id = @user.id
    Taxi.set_taxi_id(Taxi::IDLIST, @taxi)
    if @taxi.save
      current_user.taxi_count += 1
      current_user.save
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
    begin
      if params[:review][:question_id]
        @question = params[:review][:question_id]
        if Question.find_by(id: @question).answer_type == '1-5'
          @categories = ['1','2','3','4','5']
          @series_data = Answer.numerical_histogram(@taxi,@question)
          @title = Question.find_by(id: @question).content
        elsif Question.find_by(id: @question).answer_type == 'Yes/No'
          @categories = ['Yes','No']
          @series_data = Answer.yes_no_histogram(@taxi,@question)
          @title = Question.find_by(id: @question).content
        end
      end
    rescue
    end
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
