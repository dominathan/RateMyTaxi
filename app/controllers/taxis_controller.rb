class TaxisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create,:edit,:update,:destroy,:show,:index]

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
    @taxi = Taxi.find(params[:id])
  end

  def update
    @taxi = Taxi.find(params[:id])
    if @taxi.update_attributes(taxi_params)
      flash[:success] = "Taxi Updated Successfully"
      redirect_to user_taxis_path(current_user)
    else
      render 'edit'
    end
  end

  def show
    @taxi = Taxi.find(params[:id])
    @answers = Answer.where(taxi_id: @taxi.id).order('created_at DESC').paginate(
                                  :page => params[:page], :per_page => 10)
    begin
      if params[:review][:question_id]
        @question = params[:review][:question_id]
        if Question.find_by(id: @question).answer_type == '1-5'
          @categories = ['1 Rating','2 Rating','3 Rating','4 Rating','5 Rating']
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
    @taxis = @user.taxis.paginate(:page => params[:page], :per_page => 12)
  end

  def destroy
    @taxi = Taxi.find(params[:id])
    @taxi.destroy
    redirect_to user_taxis_path(current_user)
  end

  #find taxis that have received the most reviews, and sort them in order 1-5
  def most_reviews
    @top_five = Taxi.most_review_answers(current_user)
  end

  def graphs
    @final_load = []
    one_to_5_questions = Question.numerical_ids(current_user)
    one_to_5_questions.each_with_index do |question, n|
      series_data = Answer.sum_numerical_histogram(current_user,question)
      title = Question.find_by(id: question).content
      categories = ['1 Rating','2 Rating','3 Rating','4 Rating','5 Rating']
      @final_load << [series_data, title, categories]
    end
    yes_no_questions = Question.yes_no_ids(current_user)
    yes_no_questions.each_with_index do |question, n|
      series_data = Answer.sum_yes_no_histogram(current_user,question)
      title = Question.find_by(id: question).content
      categories = ['Yes','No']
      @final_load << [series_data, title, categories]
    end
    @final_load
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
