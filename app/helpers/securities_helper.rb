module SecuritiesHelper
    def update_securities_list
        byebug
        companies = Intrinio.instance.companies().parsed_response['pages']
        byebug
    end
end
