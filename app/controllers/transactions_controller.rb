class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = current_user.transactions.build(transaction_params)
    # if @holding_id.nil?
    #   byebug
    #   @holding = Transaction.find_holding(current_user, :symbol)
    #   if @holding.blank?
    #     @holding = Holding.create(symbol: transaction_params[:symbol], 
    #       quantity: transaction_params[:quantity], cost_basis: transaction_params[:price],
    #       avg_price: transaction_params[:amount])
    #   end
    #   @transaction.holding_id = @holding.id
    # end
    # Transaction.build_description
    # @transaction = current_user.transactions.build(transaction_params)
    # #@transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def purchase
    if params[:holding_id].present?
      @holding = Holding.where(id:params[:holding_id]).first
      @portfolio = @holding.portfolio
    else
      @portfolio = Portfolio.where(id:params[:portfolio_id]).first
    end
    @transaction = Transaction.new
  end
  
  def sale
    @holding = Holding.where(id:params[:holding_id]).first
    @transaction = Transaction.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:transaction, :portfolio_id, :holding_id, :date, 
        :activity, :quantity, :symbol, :description, :price, :commission, :fees, :amount)
    end
end
