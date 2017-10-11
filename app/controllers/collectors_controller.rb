class CollectorsController < ApplicationController
  #before_filter :authenticate_collector!
  #before_action :set_collector, only: [:show, :edit, :update]


  def event
    @events = Event.where(["d_event >= ?", Date.today])
  end

  def edit_collector_event
    if current_collector.update_attribute :event_id, params[:event_id]
      redirect_to root_path
    else
      render event
      logger.debug "El Evento del Collector no pudo ser actualizado"
    end
  end

  def index
    @collectors = ::Collector::all
  end

  #def edit
  #end

  def new
    @collector = Collector.new
  end

  def create
    @collector = Collector.new(collector_params)

      if @collector.save
        redirect_to collectors_path
      else
        render :new
      end
  end


  #def update
  #    if @collector.update_attributes!(collector_params)
  #      redirect_to collectors_path
  #    else
  #      render :edit
  #    end
  #end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collector
    @collector = ::Collector::find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def collector_params
    params.require(:collector).permit(:event_id, :remember_me, :name, :email, :password, :password_confirmation)
  end

end
