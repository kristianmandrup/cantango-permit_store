module CanTango::PermitStore::Loader
  class Yaml < ::CanTango::Loader::Yaml
    def initialize file_name
      @file_name = file_name
      load!
    end

    def load_yaml
      load_from_hash yml_content
    end

    def load_hash permits_hash
      return if permits_hash.empty?
      yml_content.each do |type, permits_hash|
        permits[type] ||= {}
        next if permits_hash.nil?

        permits_loader(type, permits_hash).load
      end
    rescue => e
      raise "PermissionsLoader Error: The permits for the file #{file_name} could not be loaded - cause was #{e}"      
    end

    protected
    
    def permits_loader type, permits_hash
      CanTango::PermitStore::Loader::Permits.new type, permits_hash
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