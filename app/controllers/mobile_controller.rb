class MobileController < ApplicationController
  before_action :authenticate_collector!
  before_action :have_gifts_in_stock?, except: [:club, :end]
  #before_filter :api_graph, only: [:select_friend, :publishing_post]

  def start
    #desconectar de fb
    #Limpiar las sesiones
    destroy_session_customer
  end

  def social
    #Login at Facebook
    @oauth = Koala::Facebook::OAuth.new(login_facebook_url)
    if params[:code].nil?
      #if params[:error] == 'access_denied'
      #  flash.alert: 'You must to approve permissions for App'
      #end
      @aut_fb = @oauth.url_for_oauth_code(:permissions => "public_profile,email,user_friends")
    else
      #Save session for token-fb
      session[:token_fb] = @oauth.get_access_token(params[:code])
      redirect_to posting_path
      #redirect_to select_friend_path
    end

  end

  def creating_post
    #Loading GraphAPI
    @graph = Koala::Facebook::GraphAPI.new(session[:token_fb])
    #Listing all Friends
    @me = @graph.get_object("me")
  end

  def create_customer(email, name)
    cu = Customer.create!(email: email, name: name)
    session[:customer_id] = cu.id
  end

  def select_activity
    unless current_customer #Si no hay un customer logueado...
      cu = Customer.get_customer(params[:email])
      if cu #Si ya esta registrado
        session[:customer_id] = cu.id
      else #Crear el customer con la data de fb
        create_customer(params[:email], params[:name])
      end
    end
    #Crear el Entry
    en = Entry.create!(customer_id: current_customer.id, post: params[:post], event_id: current_collector.event_id,  collector_id: current_collector.id )
    current_customer.update_attribute :entry_id, en.id

    redirect_to select_friend_path
  end

  def select_friend
    if session[:token_fb]
      #Loading GraphAPI
      @graph = Koala::Facebook::GraphAPI.new(session[:token_fb])
      #Para FAcebook REVIEW
      @oauth = Koala::Facebook::OAuth.new(ruleta_url)
      @urlfb = @oauth.url_for_oauth_code(:permissions => "publish_actions,user_photos", :display => 'popup', :auth_type => 'rerequest' )

      @friends = @graph.get_connections("me", "taggable_friends")
    else
      redirect_to login_facebook_path
    end

  end

  def publishing_post
    @graph = Koala::Facebook::GraphAPI.new(session[:token_fb])


    #Subir Imagen a server
    image = upload
    #amigos = params[:friends]
    if image
      #Subir imagen  a FB
        img = @graph.put_picture(params[:picture],  {:message => "#{current_customer.entry.post} @ChivasDominicana #ChivasNights"}, 'ChivasDominicana')
        #img = @graph.put_picture(params[:picture],  {:message => params[:post]}, 'ChivasDominicana')
      #Taguear Amigos
        params[:friends].each_value do |f|
          @graph.put_object(img['id'], 'tags', :tag_uid => f )
        end
        #@graph.put_object(img['id'], 'tags', :tag_text => '@ChivasDominicana' )
        redirect_to ruleta_path
    else
      redirect_to select_friend_path, notice: 'Por favor, vuelva a intentar.'
    end

    #redirect_to end_path

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
      if gift.update_attribute :inventory, gift.inventory - 1
        if current_customer
          current_customer.entry.update_attributes!(gift: gift.name, completed: true)
          logger.debug "Entrada Actualizada"
        else
          session[:gift] = gift.name
        end
        redirect_to club_path
      else
        logger.debug "No pudo ser guargado el gift"
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
