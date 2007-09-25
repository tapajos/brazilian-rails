module Extenso 
  @@unidade = {
    0 => "zero",  
    1 => "um",  
    2 => "dois",  
    3 => "três",  
    4 => "quatro",  
    5 => "cinco",  
    6 => "seis",  
    7 => "sete",  
    8 => "oito",  
    9 => "nove" 
  }
  @@dezena = {
    10 => "dez",  
    11 => "onze",  
    12 => "doze",  
    13 => "treze",  
    14 => "quatorze",  
    15 => "quinze",  
    16 => "dezesseis",  
    17 => "dezessete",  
    18 => "dezoito",  
    19 => "dezenove",  
    20 => "vinte",  
    30 => "trinta",  
    40 => "quarenta",  
    50 => "cinquenta",  
    60 => "sessenta",  
    70 => "setenta",  
    80 => "oitenta",  
    90 => "noventa"  }
  @@centena = {100 => "cento",  
    200 => "duzentos",  
    300 => "trezentos",  
    400 => "quatrocentos",  
    500 => "quinhentos",  
    600 => "seiscentos",  
    700 => "setecentos",  
    800 => "oitocentos",  
    900 => "novecentos"  }

  def to_extenso
     Extenso.de(self)
  end
  def Extenso.de(numero)
    n=numero.to_i.abs
    return case n
      when 0..9: @@unidade[n].to_s 
      when 10..19: @@dezena[n].to_s
      when 20..99:
        v=n % 10
        if  v== 0
          @@dezena[n].to_s
        else
          "#{@@dezena[n-v]} e #{de(v)}"
        end
      when 100
        "cem"     
      when 101..999
        v=n % 100
        if  v== 0
          @@centena[n].to_s
        else
          "#{@@centena[n-v]} e #{de(v)}"
        end
      when 1000..999999  
        m,c=n/1000,n%1000
        %(#{de(m)} mil#{c > 0 ? " e #{de(c)}":''})
      when 1_000_000..999_999_999
        mi,m=n/1_000_000,n%1_000_000
        %(#{de(mi)} milh#{mi > 1 ? 'ões':'ão'}#{m > 0 ? " e #{de(m)}" : ''})
      when 1_000_000_000..999_999_999_999
        bi,mi=n/1_000_000_000,n%1_000_000_000
        %(#{de(bi)} bilh#{bi > 1 ? 'ões':'ão'}#{mi > 0 ? " e #{de(mi)}" : ''})
      when 1_000_000_000_000..999_999_999_999_999
        tri,bi=n/1_000_000_000_000,n%1_000_000_000_000
        %(#{de(tri)} trilh#{tri > 1 ? 'ões':'ão'}#{bi > 0 ? " e #{de(bi)}" : ''})
      else
        raise "Valor excede o permitido: #{n}"
      end
  end
end

module ExtensoReal
 include Extenso

  def to_extenso_real
     ExtensoReal.de(self.to_s)
  end
 
 def ExtensoReal.de(valor)
   return 'grátis' if valor == 0
   case valor
     when Integer 
       extenso = Extenso.de(valor)
       if extenso =~ /^(.*)(ão$|ões$)/
        complemento = 'de '
       else
        complemento = ''
       end
       %(#{extenso} #{valor <= 1 ? 'real': "#{complemento}reais"})
     when Float
       real,cents=("%.2f" % valor).split(/\./).map{ |m| m.to_i}
       valor_cents=Extenso.de(cents%100)
       
       valor_cents+= case cents.to_i%100
         when 0: ""
         when 1: " centavo"
         when 2..99: " centavos"
       end 
       
       if real.to_i > 0
         "#{ExtensoReal.de(real.to_i)}#{cents > 0 ? ' e ' + valor_cents : ''}"
       else
        "#{valor_cents}"
       end
     else
         ExtensoReal.de(valor.to_s.strip.gsub(/[^\d]/,'.').to_f)
     end
   end
end