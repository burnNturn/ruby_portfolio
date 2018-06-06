class IntrinioCompaniesWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :default
    
    def perform(security_ids)
        #@securities = Security.find(security_ids)
        security_ids.each do |security_id|
            @security = Security.find(security_id)
            data_points = 'name,cik,close_price,last_price'
            options = {query: {identifier: @security.symbol, item: data_points}}
            company = Intrinio.instance.data_point(options).parsed_response["data"]
            stock = Hash.new
            company.each do |item|
                stock[item["item"]] = item["value"]
            end
            @security.description = stock['name']
            @security.identifier = stock['cik']
            @security.previous_close = stock['close_price']
            @security.current_price = stock['last_price']
            @security.last_api_call = Time.now()
            @security.save
        end
    end
end
    

    