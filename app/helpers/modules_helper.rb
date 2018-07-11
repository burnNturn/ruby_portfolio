module ModulesHelper
   
    def calculate_user_metrics
        beg_year_sum = 0    
       beg_daily_sum = 0
       current_sum = 0
       @portfolios.each do |portfolio|
            if portfolio.get_todays_beg_balance.present?
                beg_daily_sum += portfolio.get_todays_beg_balance
            else
                beg_daily_sum += 0
            end
            if portfolio.get_beg_year_balance.present?
                beg_year_sum += portfolio.get_beg_year_balance
            else
                beg_year_sum += 0
            end
           current_sum += portfolio.total_value
       end
       
       daily_gain_loss = current_sum - beg_daily_sum
       ytd_gain_loss = current_sum - beg_year_sum
       
       daily_change = (daily_gain_loss / beg_daily_sum) * 100
       ytd_change = (ytd_gain_loss / beg_year_sum) * 100
       
       @user_daily_gain_loss = daily_gain_loss.round(2)
       @user_daily_change = daily_change.round(2)
       @user_ytd_gain_loss = ytd_gain_loss.round(2)
       @user_ytd_change = ytd_change.round(2)
    end
    
    
    
    def get_indicies
        intrinio = Intrinio.instance
        
        date = Date.yesterday
        formatted_date = date.to_s(:db)
        data_raw = Intrinio.instance.prices('$DJI', 'close', formatted_date)
        data = data_raw.parsed_response['value']
        @dji_open = Intrinio.instance.prices('$DJI', 'close', formatted_date).parsed_response['close']
        @dji_close = Intrinio.instance.data_point_filtered('$DJI', 'close_price').parsed_response['value']
        
        data = Intrinio.instance.prices('$SPX', 'close', formatted_date).parsed_response['close']
        @spx_open = Intrinio.instance.prices('$SPX', 'close', formatted_date).parsed_response['close']
        @spx_close = Intrinio.instance.data_point_filtered('$SPX', 'close_price').parsed_response['value']
        
        data = Intrinio.instance.prices('$COMPQ', 'close', formatted_date).parsed_response['close']
        @compq_open = Intrinio.instance.prices('$COMPQ', 'close', formatted_date).parsed_response['close']
        @compq_close = Intrinio.instance.data_point_filtered('$COMPQ', 'close_price').parsed_response['value']
    end
end
