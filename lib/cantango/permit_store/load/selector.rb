module CanTango::PermitStore::Load
  module Selector
    sweetload :Base, :Licenses, :Users

    def self.create type, collector
      selector_class(type).new collector
    end

    def self.selector_class type
      "CanTango::PermitStore::Selector::#{type.to_s.camelize}".constantize
    end
  end
end

