class AnswersController < ApplicationController

  def new_answer_review
    if Taxi.find(params[:search])
      @taxi = Taxi.find(params[:search])
    else
      redirect_to root_path
    end
    @review = @taxi.user.reviews.last #most recent review? only allow one review? allow user to pick review?
    @questions = @review.questions.to_a
    @answer = Answer.new
  end

  def create_answer_review
    @answers = params[:answer]
    redirect_to faidls
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
