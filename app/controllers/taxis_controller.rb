class TaxisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create,:edit,:update,:destroy,:show,:index]

  def new
    @taxi = Taxi.new
  end

  #call Taxi.set_taxi_id to generate unique identifier for potential
    #reviewers to enter on home screen to leave a review
  def create
    @taxi = Taxi.new(taxi_params)
    @taxi.user_id = @user.id
    Taxi.set_taxi_id(Taxi::IDLIST, @taxi)
    if @taxi.save
      if current_user.taxi_count == nil
        current_user.taxi_count =1
      else
        current_user.taxi_count += 1
      end
      current_user.save
      flash[:success] = "Taxi Added Successfully"
      redirect_to user_taxis_path(current_user)
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

  #shows all answers that reference taxi_id
  #All User Questions with either 1-5 or Yes/No answer types
    #are generated as bar graphs, summing the counts of the answers
    #and displaying them individually by taxi
  def show
    @taxi = Taxi.find(params[:id])
    @answers = Answer.where(taxi_id: @taxi.id).order('created_at DESC')
    @final_load = []
    one_to_5_questions = Question.numerical_ids(current_user)
    one_to_5_questions.each_with_index do |question, n|
      series_data = Answer.numerical_histogram(@taxi.id,question)
      title = Question.find_by(id: question).content
      categories = ['1 Rating','2 Rating','3 Rating','4 Rating','5 Rating']
      @final_load << [series_data, title, categories]
    end
    yes_no_questions = Question.yes_no_ids(current_user)
    yes_no_questions.each_with_index do |question, n|
      series_data = Answer.yes_no_histogram(@taxi.id,question)
      title = Question.find_by(id: question).content
      categories = ['Yes','No']
      @final_load << [series_data, title, categories]
    end
    @final_load
  end

  def index
    @taxis = @user.taxis.load
  end

  def destroy
    @taxi = Taxi.find(params[:id])
    @taxi.destroy
    begin
      current_user.taxi_count -= 1
    rescue
      'nothign to see here'
    end
    redirect_to user_taxis_path(current_user)
  end

  #find taxis that have received the most reviews, and sort them in order 1-5
  def most_reviews
    @top_five = Taxi.most_review_answers(current_user)
  end

  #All User Questions with either 1-5 or Yes/No answer types
    #are generated as bar graphs, summing the counts of the answers
    #and displaying them in aggregate for all taxis
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

  def comments
    @text_answers = Answer.all_text_responses(current_user).order('created_at DESC')
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
