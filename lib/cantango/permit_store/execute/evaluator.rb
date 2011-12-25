module CanTango::PermitStore::Execute
  class Evaluator
    include CanTango::Helpers::Debug
    include CanCan::Ability
    include CanTango::Ability::Rules

    attr_reader :ability, :statement

    delegate :rules, :to => :ability

    def initialize ability, statement
      @ability, @statement = [ability, statement]
    end

    def evaluate!
      debug "Evaluating statement:"
      instance_eval statement.to_code
      self
    end
  end
end