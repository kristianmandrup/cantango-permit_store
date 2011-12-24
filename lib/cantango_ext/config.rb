module CanTango
  class Config
    sweet_scope :ns => {:CanTango => 'cantango_ext'} do
      sweetload :PermitStore, :Ability
    end
  end
end
