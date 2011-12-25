module CanTango::PermitStore::Execute
  module Selector
    sweetload :Base, :Licenses, :Users

    def self.create type, collector
      selector_class(type).new collector
    end

    def self.selector_class type
      "#{ns}::#{type.to_s.camelize}".constantize
    end
    
    def self.ns
      "CanTango::PermitStore::Selector"
    end
  end
end

