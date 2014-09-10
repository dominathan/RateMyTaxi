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
      redirect_to user_taxis_path(current_user)
    else
      redirect_to 'edit'
    end
  end

  private

    def question_params
      params.require(:question).permit(:answer_type, :content)
    end

end
