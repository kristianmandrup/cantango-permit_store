module CanTango::PermitStore::Execute
  class Statements
    attr_reader :method, :actions

    def initialize method, actions, targets
      @method = method
      @actions = actions
      @targets = targets
    end

    def to_code
      parse_statements.join("\n")
    end

    protected

    def parse_statements
      targets.inject([]) do |statements, target|
        statements << parser(target).parse
      end.flatten
    end

    def targets
      @targets ||= []
    end

    #def statement target_and_conditions
    #  CanTango::PermitStore::Statement.new method, action, target_and_conditions 
    #end

    def parser target
      CanTango::PermitStore::Parser.create_for method, actions, target
    end
  end
end
