class CustomersController < ApplicationController
  #before_action :authenticate_user!, only: [:index, :destroy, :create, :new]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        en = @customer.create_entry!(event_id: current_collector.event_id, gift: session[:gift], completed: true, collector_id: current_collector.id)
        if en
          logger.debug "Entrada #{session[:customer_id]} creada"
          @customer.update_attribute :entry_id, en.id
        end
        session[:customer_id] = @customer.id
        format.html { redirect_to djs_mobile_path, notice: 'Sus datos fueron registrados exitosamente.' }
        format.json { render :show, status: :created, location: @customer }

      else
        format.html { redirect_to djs_mobile_path, alert: 'Este email ya esta registrado.' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to djs_mobile_path}
        format.json { render :show, status: :ok, location: @customer }

        if @customer.entry.update_attribute :completed, true
          logger.debug "Entrada #{@customer.entry_id} Actualizada"
        end
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :birth, :city, :mobile, :email, :interest, :entry_id)
    end
end
