class MobileController < ApplicationController
  before_action :authenticate_collector!
  before_action :have_gifts_in_stock?, except: [:club, :end, :djs, :create_vote, :no_customer_filled]
  #before_filter :api_graph, only: [:select_friend, :publishing_post]

  def start
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
  end

  def save_gift
    gift = Gift.find params[:gift_id]

    if gift.nil?
      redirect_to ruleta_path, alert: 'Lo sentimos, vuelva a seleccionar su regalo...'
    else
      #Restar el regalo ganado
      if gift.inventory > 0
        if gift.update_attribute :inventory, gift.inventory - 1
          if session[:gift] = gift.name
            #redirect_to djs_mobile_path
            redirect_to club_path
          end
        else
          logger.debug "No pudo ser guargado el gift"
        end
      else
        redirect_to ruleta_path, alert: 'Lo sentimos, Ya este regalo estaba reservado. ¡vuelve a intentar!'
        logger.debug "ERROR: REGALO NO GUARDADO. Ya este regalo estaba reservado"
      end
    end

  end

  def club
    @customer = Customer.new
  end

  def no_customer_filled
    if request.post?
      if Entry.create!(event_id: current_collector.event_id, gift: session[:gift], completed: true, collector_id: current_collector.id)
        redirect_to end_path
      end
    end
  end

  def end
    destroy_session_customer
  end

  protected
  def have_gifts_in_stock?
    if current_collector.event.gifts.in_stock.size > 0
      true
    else
      render "mobile/no_gifts"
    end
  end
end
