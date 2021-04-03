module AccountingFeature
  class Title
    attr_accessor :raw
    delegate :field1, :field2, to: :raw

    def initialize(raw)
      self.raw = raw
    end
  end
end