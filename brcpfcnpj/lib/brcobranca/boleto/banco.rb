module BrCobranca::Boleto
  class Banco
    class << self
      
      def new(code)
        bank = guess(code)
        bank.new
      end
      
      def guess(code)
        handler = handlers.detect do |handler|
          handler.understands_code?(code)
        end
        handler
      end

      @@handlers = Array.new
      def add_handler(handler)
        @@handlers << handler
      end

      def handlers
        @@handlers
      end
    end
    
  end
end
