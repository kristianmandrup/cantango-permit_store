module CanTango::PermitStore::Execute
  class Kompiler
    sweetload :Statements, :StatementsBuilder
    
    attr_reader :rules, :categories

    def initialize rules
      @rules = rules
    end

    def to_hashie
      Hashie::Mash.new eval_statements
    end

    def eval_statements
      {:can => can_eval, :cannot => cannot_eval}
    end

    def can_eval &block
      build_statements :can, &block
    end

    def cannot_eval &block
      build_statements :cannot, &block
    end

    protected

    include CanTango::PermitStore::Execute::Kompiler::Statements
  end
end