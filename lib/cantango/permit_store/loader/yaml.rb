module CanTango::PermitStore::Loader
  class Yaml < ::CanTango::Loader::Yaml
    def initialize file_name
      @file_name = file_name
    end

    def load
      hash_loader.load
    rescue => e
      raise "PermitStore::Loader::Yaml - The permits could not be loaded. Cause was: #{e}"            
    end

    protected
    
    def hash_loader
      @hash_loader ||= CanTango::PermitStore::Loader::Hash.new yml_content
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