class IntrinioWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :default
    
    def perform
        pages = Intrinio.instance.companies().parsed_response['total_pages']
        (1...pages).each do |page|
            options = {query: {page_number: page}}
            #companies = IntrinioWorker.perform_async(options).parsed_response['data']
            companies = Intrinio.instance.companies(options).parsed_response['data']
            companies.each do |company|
                @security = Security.new
                @security.load_security(company)
                @security.save
        
            end
        end
    end
end