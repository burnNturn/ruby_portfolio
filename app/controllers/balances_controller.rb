class BalancesController < ApplicationController
   
   
   def create
       @balance = Balance.new(balance_params)
       @balance.save
   end
   
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance
      @balance = Balance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def balance_params
      params.require(:balance).permit(:portfolio, :date, :value, :yearly, :quarterly, :monthly, :weekly)
    end
end