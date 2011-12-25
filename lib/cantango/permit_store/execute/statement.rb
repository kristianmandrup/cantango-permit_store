module CanTango::PermitStore::Execute
  class Statement
    attr_reader :method, :actions, :conditions

    def initialize method, actions, conditions = {}
      @method, @actions, @conditions = [method, actions, conditions]
    end

    def to_code
      line = conditions.empty? ? "#{method}(:#{actions})" : "#{method}(:#{actions}, #{conditions})"
    end
  end
end
