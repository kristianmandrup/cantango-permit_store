module CanTango::PermitStore::Execute
  class Compiler
    sweetload :Statements
    
    attr_reader :permit, :categories

    def initialize
    end

    def compile! permit
      @permit = permit
      self
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

    include CanTango::PermitStore::Execute::Compiler::Statements
  end
end