module AccountingSubject
  module UserActor
    class ClosingUseCase
      attr_accessor :actor

      def initialize(actor)
        self.actor = actor
      end
    end
  end
end