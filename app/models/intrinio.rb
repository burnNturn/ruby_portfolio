

class Intrinio
    include HTTParty
    include Singleton
    
    base_uri ENV['INTRINIO_URI']
    
    def initialize()
       @auth = { username: ENV['INTRINIO_USERNAME'], password: ENV['INTRINIO_PASSWORD'] }  
    end
    
    def quick_quote(symbol)
        data_point_filtered(symbol, 'last_price').parsed_response["value"]
    end
    
    
    def data_point_filtered(symbol, items)
        options = {query: {identifier: symbol, item: items}}
        merge_auth(options)
        self.class.get('/data_point', options)
    end
    
    def data_point(symbol)
        options = {query: {identifier: symbol}}
        merge_auth(options)
        self.class.get('/data_point', options)
    end
    
    
    def prices(symbols, items, formatted_date)
        options = {query: {identifier: symbols, item: items, start_date: formatted_date}}
        merge_auth(options)
        self.class.get('/prices', options)
    end
    
    def companies(options = {})
        merge_auth(options)
        self.class.get('/companies', options)
    end
    
    def securities(options = {})
        merge_auth(options)
        self.class.get('/securities', options)
    end
    
    def multi_quote(symbols)
        
    end
    
    private
    
    def merge_auth(options)
        # merge authenticatation parameters to each call
        options.merge!(basic_auth: @auth)
    end

end