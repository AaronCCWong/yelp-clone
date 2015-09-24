class HelpfulnessController < ApplicationController
  def index
    @helpfulnesses = Helpfulness.all
    render :index
  end

  def create
    @helpfulness = Helpfulness.create(helpfulness_params)
    if @helpfulness.save
      render json: @helpfulness
    else
      render json: @helpfulness.errors.full_messages, status: :unproccessable_entity
    end
  end

  def destroy
    @helpfulness = Helpfulness.find(params[:id])
    @helpfulness.destroy!
    render json: @helpfulness
  end

  private

  def helpfulness_params
    params.require(:helpfulness).permit(:helpfulness, :review_id, :user_id)
  end
end
