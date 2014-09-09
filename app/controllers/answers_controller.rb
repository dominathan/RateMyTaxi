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
    @answers = params[:answers]
    binding.pry
    for an in @answers
      answer = Answer.new
      answer.content = an['content']
      answer.taxi_id = an['taxi_id']
      answer.question_id = an['question_id']
      answer.save
    end
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
