class MobileController < ApplicationController
  before_action :authenticate_collector!
  before_action :have_gifts_in_stock?, except: [:club, :end, :djs, :create_vote]
  #before_filter :api_graph, only: [:select_friend, :publishing_post]

  def start
    #desconectar de fb
    #Limpiar las sesiones
    destroy_session_customer
  end

  def djs
    @djs = Dj.all
  end

  def create_vote
    @vote = Vote.new(dj_id: params[:dj_id])
    if @vote.save
      redirect_to club_path
      logger.debug "El voto de DJ fue creado"
    end
  end


  def create_customer(email, name)
    cu = Customer.create!(email: email, name: name)
    session[:customer_id] = cu.id
  end

  def upload
    uploaded_io = params[:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    #"http://#{request.host_with_port}/uploads/#{uploaded_io.original_filename}"
  end

  def spin
    @gifts = Gift.where(["event_id = ?", current_collector.event_id]).order('RAND()')

    #@win = g
  end

  def save_gift
    gift = Gift.find params[:gift_id]

      #Restar el regalo ganado
    if gift.inventory > 0
      if gift.update_attribute :inventory, gift.inventory - 1
        if current_customer
          current_customer.entry.update_attributes!(gift: gift.name, completed: true)
          logger.debug "Entrada Actualizada"
        else
          session[:gift] = gift.name
        end
        redirect_to djs_mobile_path
      else
        logger.debug "No pudo ser guargado el gift"
      end
    else
      redirect_to ruleta_path, alert: 'Lo sentimos, Ya este regalo estaba reservado. ¡vuelve a intentar!'
      logger.debug "ERROR: REGALO NO GUARDADO. Ya este regalo estaba reservado"
    end

  end

  def club
    if current_customer
      @customer = Customer.find(current_customer)
    else
      @customer = Customer.new
    end
  end

  def end

  end

  protected
  def have_gifts_in_stock?
    if current_collector.event.gifts.in_stock.size > 0
      true
    else
      render "mobile/no_gifts"
    end
  end

  def api_graph
  @graph = Koala::Facebook::GraphAPI.new(session[:token_fb])
  end
end
