class GiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  # GET /gifts
  # GET /gifts.json
  def index
    @gifts = Gift.all
  end

  # GET /gifts/1
  # GET /gifts/1.json
  def show
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
  end

  # GET /gifts/1/edit
  def edit
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @gift = Gift.new(gift_params)

    respond_to do |format|
      if @gift.save
        format.html { redirect_to @gift, notice: 'Gift was successfully created.' }
        format.json { render :show, status: :created, location: @gift }
      else
        format.html { render :new }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifts/1
  # PATCH/PUT /gifts/1.json
  def update
    respond_to do |format|
      if @gift.update(gift_params)
        format.html { redirect_to @gift, notice: 'Gift was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift }
      else
        format.html { render :edit }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.json
  def destroy
    @gift.destroy
    respond_to do |format|
      format.html { redirect_to gifts_url, notice: 'Gift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_gifts

  end

  def creating_gifts
    g = Event.find params[:event_id]
    if g.gifts.blank?
      #Special guest
      Gift.create!([type_g: 0, name: 'Special guest', event_id: params[:event_id], inventory: params[:gifts][:guest], predicted: params[:gifts][:guest], image: 'cb-invitation.png'])

      #Bolso Playa
      Gift.create!([type_g: 0, name: 'Bolso Playa', event_id: params[:event_id], inventory: params[:gifts][:bolso], predicted: params[:gifts][:bolso], image: 'cb-bolso.png'])

      #Tshirt
      Gift.create!([type_g: 0, name: 'T-shirt Absolut', event_id: params[:event_id], inventory: params[:gifts][:tshirt], predicted: params[:gifts][:tshirt], image: 'cb-tshirt.png'])
      Gift.create!([type_g: 0, name: 'T-shirt Absolut', event_id: params[:event_id], inventory: params[:gifts][:tshirt1], predicted: params[:gifts][:tshirt1], image: 'cb-tshirt.png'])
      Gift.create!([type_g: 0, name: 'T-shirt Absolut', event_id: params[:event_id], inventory: params[:gifts][:tshirt2], predicted: params[:gifts][:tshirt2], image: 'cb-tshirt.png'])

      Gift.create!([type_g: 0, name: 'Gorra Absolut', event_id: params[:event_id], inventory: params[:gifts][:gorra], predicted: params[:gifts][:gorra], image: 'cb-gorra.png'])
      Gift.create!([type_g: 0, name: 'Gorra Absolut', event_id: params[:event_id], inventory: params[:gifts][:gorra1], predicted: params[:gifts][:gorra1], image: 'cb-gorra.png'])

      Gift.create!([type_g: 0, name: 'Absolut Breeze Shots', event_id: params[:event_id], inventory: params[:gifts][:cock], predicted: params[:gifts][:cock], image: 'cb-shot.png'])
      Gift.create!([type_g: 0, name: 'Absolut Breeze Cocktail', event_id: params[:event_id], inventory: params[:gifts][:cock1], predicted: params[:gifts][:cock1], image: 'cb-copa.png'])

      redirect_to event_path(params[:event_id]), notice: "Todos los regalos fueron creados"
    else
      redirect_to event_path(params[:event_id]), notice: "Ya este evento contiene Regalos. Por favor editarlos"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_params
      params.require(:gift).permit(:name, :inventory, :predicted, :priority, :event_id)
    end
end
