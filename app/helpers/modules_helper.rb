module ModulesHelper
    def get_indicies
        intrinio = Intrinio.instance
        
        date = Date.yesterday
        formatted_date = date.to_s(:db)
        data_raw = Intrinio.instance.prices('$DJI', 'close', formatted_date)
        data = data_raw.parsed_response['value']
        @dji_open = Intrinio.instance.prices('$DJI', 'close', formatted_date).parsed_response['close']
        @dji_close = Intrinio.instance.data_point_filtered('$DJI', 'last_price').parsed_response['value']
        
        data = Intrinio.instance.prices('$SPX', 'close', formatted_date).parsed_response['close']
        @spx_open = Intrinio.instance.prices('$SPX', 'close', formatted_date).parsed_response['close']
        @spx_close = Intrinio.instance.data_point_filtered('$SPX', 'close_price').parsed_response['value']
        
        data = Intrinio.instance.prices('$COMPQ', 'close', formatted_date).parsed_response['close']
        @compq_open = Intrinio.instance.prices('$COMPQ', 'close', formatted_date).parsed_response['close']
        @compq_close = Intrinio.instance.data_point_filtered('$COMPQ', 'close_price').parsed_response['value']
    end
end
