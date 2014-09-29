class AnswersController < ApplicationController

  def new_answer_review
    begin
      @taxi = Taxi.find(params[:search])
      @review = @taxi.user.reviews.where(use_this_review: true).take!
      @questions = @review.questions.to_a.sort
      @answer = Answer.new
    rescue
      flash[:error] = "Taxi not found. Please use the 6 digit code located on the sticker, or scan the QR Code."
      redirect_to root_path
    end
  end

  #if a reviewer submits answers, only save the answers that have content
  def create_answer_review
    @answers = params[:answers]
    for an in @answers
      if an['content'] != ""
        answer = Answer.new
        answer.content = an['content']
        answer.taxi_id = an['taxi_id']
        answer.question_id = an['question_id']
        answer.save
      end
    end
    #carry taxi_id to store Rider information with correct company
    redirect_to new_rider_path(:company_id => Rider.get_company_id(params[:taxi_carryover]))
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
