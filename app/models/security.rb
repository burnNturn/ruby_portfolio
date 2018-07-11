class Security < ActiveRecord::Base
    has_many :holding
    
    has_many :holdings 
    
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
        if self.needs_update or self.current_price.nil?
            data_points = 'name,cik,close_price,last_price'
            options = {query: {identifier: self.symbol, item: data_points}}
            company = Intrinio.instance.data_point_filtered(symbol, data_points).parsed_response["data"]
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
    
    def update_security_hard
        data_points = 'name,cik,close_price,last_price'
        options = {query: {identifier: self.symbol, item: data_points}}
        company = Intrinio.instance.data_point_filtered(symbol, data_points).parsed_response["data"]
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
    
    def institutional_holders
        sym = self.symbol
        options = {query: {identifier: sym}}
        pages = Intrinio.instance.institutional_holders(options).parsed_response["total_pages"]
        @holders = []
        # options = {query: {identifier: sym, page_number: 1}}
        # @holders = Intrinio.instance.institutional_holders(options).parsed_response['data']
        
        (1...pages).each do |page|
            options = {query: {identifier: sym, page_number: page}}
            @holders += Intrinio.instance.institutional_holders(options).parsed_response['data']
        end
        @holders
    end
    
    def basic_eps
        sym = self.symbol
        start_date = (Date.today - (365 * 2)).to_s
        options = {query: {identifier: sym, item: 'basiceps', start_date: start_date}}
        @basic_eps = Intrinio.instance.historical_data(options).parsed_response['data']

        @basic_eps
    end
    
    def diluted_eps
        
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
