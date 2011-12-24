module CanTango
  class Config
    class Ability
      sweet_scope :ns => {:CanTango => 'cantango_ext'} do
        sweetload :PermitStore
      end
    end
  end
end
