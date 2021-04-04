module AccountingSubject
  module ClosingSwimLane
    class UserActor
      attr_accessor :actor

      def initialize(actor)
        self.actor = actor
      end
    end
  end
end