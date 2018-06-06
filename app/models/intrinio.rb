

class Intrinio
    include HTTParty
    include Singleton
    
    base_uri ENV['INTRINIO_URI']
    
    def initialize()
       @auth = { username: ENV['INTRINIO_USERNAME'], password: ENV['INTRINIO_PASSWORD'] }  
    end
    
    def quick_quote(symbol)
        options = {query: {identifier: symbol, item: 'last_price'}}
        data_point(options).parsed_response["value"]
        
    end
    
    def data_point(options = {})
        merge_auth(options)
        self.class.get('/data_point', options)
    end
    
    def prices(symbol, options = {})
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