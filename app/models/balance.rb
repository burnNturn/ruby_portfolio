class Balance < ActiveRecord::Base
    before_save :set_date_frames
    
    belongs_to :portfolio
    
    
    private
    
    def set_date_frames
        
        

        
        if self.date.yday == 1
            self.yearly = true
        else
            self.yearly = false
        end
        
        if self.date == self.date.beginning_of_quarter
            self.quarterly = true
        else
            self.quarterly = false
        end
        
        if self.date.mday == 1
            self.monthly = true
        else
            self.monthly = false
        end
        
        if self.date.wday == 1
            self.weekly = true
        else
            self.weekly = false
        end
            
        return true
    end

end
