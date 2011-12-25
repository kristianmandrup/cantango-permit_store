module CanTango::PermitStore::Execute
  class Evaluator
    include CanTango::Helpers::Debug
    include CanCan::Ability
    include CanTango::Ability::Rules

    attr_reader :ability, :rule

    delegate :rules, :to => :ability

    def initialize ability, rule
      @ability = ability
      @rule = rule
    end

    def evaluate!
      debug "Evaluating rule:"
      debug rule.can
      debug rule.cannot
      instance_eval rule.can if rule.can?
      instance_eval rule.cannot if rule.cannot?
      self
    end
  end
end