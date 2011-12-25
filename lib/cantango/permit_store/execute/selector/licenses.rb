module CanTango::PermitStore::Execute::Selector
  class Licenses < Base
    def initialize subject
    end

    def relevant? permit
      false
    end
  end
end