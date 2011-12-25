module CanTango::PermitStore::Execute::Selector
  class Base
    attr_reader :subject

    def initialize subject
      @subject = subject
    end

    def select permits
      permits.select { |permit| relevant? permit }
    end
  end
end