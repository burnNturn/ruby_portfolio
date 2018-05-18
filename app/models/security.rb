class Security < ActiveRecord::Base
    before_save :update_security
    
    def load_security(company)
        self.asset_class = 'stock'
        self.symbol = company['ticker']
        self.description = company['name']
        self.identifier = company['cik']
        self.last_api_call = Time.now()
    end
    
    
    protected
    
    def update_security
        if self.needs_update
            options = {query: {identifier: self.symbol, item: 'name,cik,close_price,last_price'}}
            company = Intrinio.instance.data_point(options).parsed_response["data"]
            stock = Hash.new
            company.each do |item|
                stock[item["item"]] = item["value"]
            end
            self.asset_class = 'stock'
            self.description = stock['name']
            self.identifier = stock['cik']
            # stock = Intrinio.instance.prices(self.symbol)
            self.previous_close = stock['close_price']
            self.current_price = stock['last_price']
            self.last_api_call = Time.now()
        end
    end
    
    def needs_update
        update_interval = 20*60
       if last_api_call.ago >= update_interval
           true
       else
           false
       end
    end
end
