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
  
old_verbose = $VERBOSE
$VERBOSE = nil
MONTHNAMES = [nil] + %w(Janeiro Fevereiro Marco Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)
DAYNAMES = %w(Domingo Segunda-Feira Terca-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sabado)
ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez)
ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sab)
$VERBOSE = old_verbose

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
