require 'yaml'

module CanTango
  class YamlStorePermitStore < PermitStore
    attr_reader :path, :last_load_time

    # for a YamlStore, the name is the name of the yml file
    # options: extension, path

    def initialize name, options = {}
      super
    end

    def load!
      loader.load!
      @last_load_time = Time.now
    end

    def load_from_hash hash
      loader.load_from_hash hash
    end

    # return cached permissions if file has not changed since last load
    # otherwise load permissions again to reflect changes!
    def permissions
      return @permissions if changed?
      @permissions = loader.permissions
    end

    def changed?
      return true if !last_load_time
      last_modify_time <= last_load_time
    end

    def last_modify_time
      File.mtime(file_path)
    end

    CanTango.config.permission_engine.types.each do |type|
      define_method(:"#{type}_permissions") do
        loader.send(:"#{type}_permissions") || {}
      end

      define_method(:"#{type}_permissions_rules") do
        send(:"#{type}_permissions").inject({}) do |result,(pk,pv)| 
          result.merge(pv.to_hash)
        end
      end

      define_method(:"#{type}_permissions_to_hash") do
        { type.to_s => send(:"#{type}_permissions_rules") }
      end

      define_method(:"#{type}_compiled_permissions") do
        loader.send(:"#{type}_compiled_permissions")
      end

      # @stanislaw: this needs revision!

      alias_method :"#{type}_rules", :"#{type}_compiled_permissions"
    end

    def save! perms = nil
      save_permissions(perms) if perms

      File.open(file_path, 'w') do |f|
        f.write to_yaml
      end
    end

    def save_permissions perms
      load_from_hash perms
    end

    protected

    def permission_types
      CanTango.config.engine(:permission).types
    end

    def to_yaml
      permission_types.inject({}) do |collection, type|
        collection.merge(send(:"#{type}_permissions_to_hash"))
      end.to_yaml.gsub(/"(@\w+)"/,'\1') # hash.to_yaml leaves quotes on strings prefixed with @
    end

    def loader
      @loader ||= CanTango::PermissionEngine::Loader::Permissions.new file_path
    end

    def file_path
      File.join(path, file_name)
    end

    private

    def file_name
      [name, extension].join('.')
    end

    def extension
      @extension || default_ext
    end

    def default_ext
      'yml'
    end

  end
end

