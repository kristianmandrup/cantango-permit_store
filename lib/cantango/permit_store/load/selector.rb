module CanTango::PermitStore::Load
  module Selector
    sweetload :Base, :Licenses, :Roles, :RoleGroups, :Users, :UserTypes, :AccountTypes

    def self.create type, collector
      selector_class(type).new collector
    end

    def self.selector_class type
      "CanTango::PermissionEngine::Selector::#{type.to_s.camelize}".constantize
    end
  end
end

