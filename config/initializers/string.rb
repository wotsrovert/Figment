class String
    
    def or( _str )
        if self.blank?
            _str
        else
            self
        end
    end
end