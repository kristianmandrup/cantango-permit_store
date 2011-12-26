module CanTango::PermitStore::Execute::Statement
  class Multi
    attr_reader :rules

    def initialize rules
      @rules = rules
    end

    def to_code
      parse_statements.join("\n")
    end

    protected

    def parse_statements
      rules.each do |meth, rule|
        rule.each do |action, targets|
          targets.each do |target|
            statements << parser(meth, action, target).parse
          end
        end
      end
      statements
    end

    def statements
      @statements ||= []
    end

    def parser meth, action, target
      CanTango::PermitStore::Parser.create_for meth, action, target
    end
  end
end
