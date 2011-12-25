module CanTango::PermitStore::Loader
  class Yaml < ::CanTango::Loader::Yaml
    attr_accessor :permissions

    def initialize file_name
      @file_name = file_name
      load!
    end

    def load!
      load_from_hash yml_content
    rescue => e
      raise "PermissionsLoader Error: The permissions for the file #{file_name} could not be loaded - cause was #{e}"
    end

    def load_from_hash hash
      return if hash.empty?
      hash.each do |type, type_permits|
        permits[type] ||= {}

        next if type_permits.nil?

        type_permits.each do |type_permit, rules|
          parser(type_permit, rules).parse do |permit|
            permits[type][permit.name] = permit
          end
        end
      end
    end

    def permits
      @permits ||= Hashie::Mash.new
    end

    def parser permit, rules
      @parser ||= CanTango::PermitStore::Parser::Permits.new permit, rules
    end
=begin
    CanTango.config.engine(:permit_store).types.each do |type|
      define_method(:"#{type}_permissions") {
        permissions.send(:"#{type}")
      }

      define_method(:"#{type}_compiled_permissions") do
        type_permissions = send(:"#{type}_permissions")

        return Hashie::Mash.new if !type_permissions || type_permissions.empty?

        compiled_sum = send(:"#{type}_permissions").inject({}) do |compiled_sum, (actor, permission)|
          compiled_sum.merge(permission.to_compiled_hash)
        end

        Hashie::Mash.new(compiled_sum)
      end
    end
=end
  end
end