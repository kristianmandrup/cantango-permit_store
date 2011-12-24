module CanTango
  module Config
    module Ability
      sweet_scope :ns => {:CanTango => 'cantango_ext'} do
        sweetload :PermitStore
      end
    end
  end
end
