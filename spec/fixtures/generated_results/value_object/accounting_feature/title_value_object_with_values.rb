module AccountingFeature
  class TitleValueObject
    attr_accessor :value1, :value2

    def initialize(value1, value2)
      self.value1 = value1
      self.value2 = value2
    end
  end
end