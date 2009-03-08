module BrCobranca::Boleto
  class BancoDoBrasil < Banco
    class << self
      def understands_code?(code)
        code == "001"
      end
    end
  end
end