class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  def index
    @votes = Vote.all

  end

  def show
  end

  def new
    @vote = Vote.new
  end

  def edit
  end

  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vote
      @vote = Vote.find(params[:id])
    end

    def vote_params
      params.require(:vote).permit(:vote_id, :customer_id)
    end
end
