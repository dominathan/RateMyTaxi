class AnswersController < ApplicationController

  def new_answer_review
    if Taxi.find(params[:search])
      @taxi = Taxi.find(params[:search])
      @review = @taxi.user.reviews.last #most recent review? only allow one review? allow user to pick review?
      @questions = @review.questions.to_a.sort
      @answer = Answer.new
    else
      flash[:danger] = "Taxi not found. Please use the 6 digit code."
      redirect_to root_path
    end
  end

  def create_answer_review
    @taxi = Taxi.find(params[:search])
    @answers = params[:answer]
    @review = @taxi.user.reviews.last #most recent review? only allow one review? allow user to pick review?
    @questions = @review.questions.to_a.sort
    redirect_to root_path
  end

  def index
  end

  def show
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end

end
