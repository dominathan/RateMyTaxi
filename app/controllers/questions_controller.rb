class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "Question Updated Successfully"
      redirect_to user_review_path(current_user,@question.review)
    else
      redirect_to 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to user_review_path(current_user, current_user.reviews.last)
  end


  private

    def question_params
      params.require(:question).permit(:answer_type, :content)
    end

end
