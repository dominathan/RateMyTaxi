class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def new
    @review = Review.new
    @review.questions.build
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Review Created Successfully"
      redirect_to user_reviews_path(current_user)
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = "Review Updated Successfully"
      redirect_to user_review_path(current_user, @review)
    else
      render 'edit'
    end
  end

  def show
    @review = Review.find(params[:id])
    @questions = @review.questions.order(:id).load
  end

  def index
    @reviews = current_user.reviews.order(:id).load
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_reviews_path(current_user)
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def review_params
      params.require(:review).permit(:name, questions_attributes: [:id, :content, :answer_type])
    end

end
