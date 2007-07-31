module ActiveSupport::CoreExtensions::String::Conversions
    def to_date
      if /(\d{1,2})\W(\d{1,2})\W(\d{4})/ =~ self
        ::Date.new($3.to_i, $2.to_i, $1.to_i)
      else
        ::Date.new(*ParseDate.parsedate(self)[0..2])
      end
    end
end

class Date

  def to_s(locale = nil)
    return send("to_s_#{locale.downcase}") if locale && locale.downcase == "br"
    strftime
  end
  
  def to_s_br
    strftime("%d/%m/%Y")
  end
  
  def self.valid?(date)
      begin
        date = date.to_date
        Date.valid_civil?(date.year, date.month, date.day)        
      rescue
        return false
      end
      true
  end
  
end