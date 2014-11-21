class DjsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dj, only: [:show, :edit, :update, :destroy]


  def index
    @djs = Dj.all
  end

  def show

  end

  def new
    @dj = Dj.new
  end

  def edit
  end

  def create
    @dj = Dj.new(dj_params)

    @dj.image = upload

    respond_to do |format|
      if @dj.save
        format.html { redirect_to @dj, notice: 'dj was successfully created.' }
        format.json { render :show, status: :created, location: @dj }
      else
        format.html { render :new }
        format.json { render json: @dj.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    uploaded_io = params[:dj][:image]
    new_name = [DateTime.now.to_i, uploaded_io.original_filename].join('')
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      File.rename(file, Rails.root.join('public', 'uploads', new_name))
    end
    new_name
  end

  def update
    respond_to do |format|
      #@dj.image = upload

      if @dj.update(dj_params)
        format.html { redirect_to @dj, notice: 'dj was successfully update.' }
        format.json { render :show, status: :created, location: @dj }
      else
        format.html { render :edit }
        format.json { render json: @dj.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dj.destroy
    respond_to do |format|
      format.html { redirect_to djs_url, notice: 'DJ was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_dj
      @dj = Dj.find(params[:id])
    end

    def dj_params
      params.require(:dj).permit(:name, :image)
    end
end
