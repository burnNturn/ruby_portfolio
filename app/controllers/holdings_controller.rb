class HoldingsController < ApplicationController
  before_action :set_holding, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /holdings
  # GET /holdings.json
  def index
    @holdings = current_user.holdings
  end
  
  def user_index
    @holdings = Holding.where(user: current_user)
  end

  # GET /holdings/1
  # GET /holdings/1.json
  def show
    if !Security.exists?(@holding.security_id) 
      @security = Security.where(symbol: @holding.symbol).first
      @holding.security_id = @security.id
      @holding.save
    end
  end

  # GET /holdings/new
  def new
    @portfolio = Portfolio.where(id:params[:portfolio_id])
    @holding = Holding.new
    #@holding.portfolio = @portfolio
    
  end

  # GET /holdings/1/edit
  def edit
  end

  # POST /holdings
  # POST /holdings.json
  def create
    # @portfolio = Portfolio.find(holding_params)
    @holding = current_user.holdings.build(holding_params)
    # @holding = Holding.new(holding_params)

    respond_to do |format|
      if @holding.save
        format.html { redirect_to modules_url, notice: 'Holding was successfully created.' }
        format.json { render :show, status: :created, location: @holding }
      else
        format.html { render :new }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holdings/1
  # PATCH/PUT /holdings/1.json
  def update
    respond_to do |format|
      if @holding.update(holding_params)
        format.html { redirect_to @holding, notice: 'Holding was successfully updated.' }
        format.json { render :show, status: :ok, location: @holding }
      else
        format.html { render :edit }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holdings/1
  # DELETE /holdings/1.json
  def destroy
    @holding.destroy
    respond_to do |format|
      format.html { redirect_to holdings_url, notice: 'Holding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holding
      @holding = Holding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def holding_params
      params.require(:holding).permit(:holding, :portfolio_id, :security_id, :symbol, :asset_class, 
        :quantity, :date_opened, :cost_basis, :avg_price)
    end
    
end 
