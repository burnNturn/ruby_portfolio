

class Intrinio
    include HTTParty
    base_uri ENV['INTRINIO_URI']
    
    def initialize()
       @auth = { username: ENV['INTRINIO_USERNAME'], password: ENV['INTRINIO_PASSWORD'] }  
    end
    
    def get_quote(symbol)
        options = {basic_auth: @auth, query: {identifier: 'AAPL', item: 'last_price'}}
        self.class.get('/data_point', options)
    end
end