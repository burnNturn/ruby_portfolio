class Security < ActiveRecord::Base
    
    def load_security(company)
        self.asset_class = 'stock'
        self.symbol = company['ticker']
        self.description = company['security_name']
        self.identifier = nil
        self.last_api_call = Time.now()
    end
    
    
    def get_quote

        self.update_security
        self.reload
        return self.current_price
    end
    
    
    def update_security
        byebug
        if self.needs_update or self.current_price.nil?
            data_points = 'name,cik,close_price,last_price'
            options = {query: {identifier: self.symbol, item: data_points}}
            company = Intrinio.instance.data_point(options).parsed_response["data"]
            stock = Hash.new
            company.each do |item|
                stock[item["item"]] = item["value"]
            end
            self.description = stock['name']
            self.identifier = stock['cik']
            self.previous_close = stock['close_price']
            self.current_price = stock['last_price']
            self.last_api_call = Time.now()
            self.save
        end
    end
    
    
    protected
    
    def needs_update
        update_interval = 20*60
        begin
            if (self.last_api_call + update_interval) <= Time.now()
                true
            else
                false
            end
        rescue 
            true
        end
    end
end
