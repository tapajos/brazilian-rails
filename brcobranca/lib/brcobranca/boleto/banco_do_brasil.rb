module BrCobranca::Boleto
  class BancoDoBrasil < Banco
    BrCobranca::Boleto::Banco.add_handler(self)
    class << self
      def understands_code?(code)
        code == "001"
      end
    end
  end
end