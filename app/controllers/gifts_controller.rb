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
      #Speaker
      Gift.create!([type_g: 0, name: 'Bluetooth Speaker Absolut', event_id: params[:event_id], inventory: params[:gifts][:speaker], predicted: params[:gifts][:speaker], image: 'cb-speaker.png'])

      #Mochila
      Gift.create!([type_g: 0, name: 'Mochila Absolut', event_id: params[:event_id], inventory: params[:gifts][:bag], predicted: params[:gifts][:bag], image: 'cb-bag.png'])

      #Bolígrafo 3 en 1 Absolut
      Gift.create!([type_g: 0, name: 'Bolígrafo 3 en 1 Absolut', event_id: params[:event_id], inventory: params[:gifts][:pencil], predicted: params[:gifts][:pencil], image: 'cb-pencil.png'])
      Gift.create!([type_g: 0, name: 'Bolígrafo 3 en 1 Absolut', event_id: params[:event_id], inventory: params[:gifts][:pencil1], predicted: params[:gifts][:pencil1], image: 'cb-pencil.png'])
      
      #Especial
      Gift.create!([type_g: 0, name: 'Especial Absolut', event_id: params[:event_id], inventory: params[:gifts][:special], predicted: params[:gifts][:special], image: 'cb-especial.png'])
      
      #Volver A intentar - Con este regalo utilizaremos el espacio para mostrar el volver a intentar - Tipo: 20
      Gift.create!([type_g: 20, name: 'Volver a Intentar', event_id: params[:event_id], inventory: 1, predicted: 1, image: 'cb-volveraintentar.png'])
      Gift.create!([type_g: 20, name: 'Volver a Intentar', event_id: params[:event_id], inventory: 1, predicted: 1, image: 'cb-volveraintentar.png'])

    
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
