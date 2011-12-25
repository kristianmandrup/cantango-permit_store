require 'yaml'

module CanTango
  module PermitStore
    class Yaml < Base
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

      # return cached permits if file has not changed since last load
      # otherwise load permits again to reflect changes!
      def permits
        return @permits if changed?
        @permits = loader.permits
      end

      def changed?
        return true if !last_load_time
        last_modify_time <= last_load_time
      end

      def last_modify_time
        File.mtime(file_path)
      end

=begin
      CanTango.config.engine(:permit_store).types.each do |type|
        define_method(:"#{type}_permits") do
          loader.send(:"#{type}_permits") || {}
        end

        define_method(:"#{type}_permits_rules") do
          send(:"#{type}_permits").inject({}) do |result,(pk,pv)| 
            result.merge(pv.to_hash)
          end
        end

        define_method(:"#{type}_permits_to_hash") do
          { type.to_s => send(:"#{type}_permits_rules") }
        end

        define_method(:"#{type}_compiled_permits") do
          loader.send(:"#{type}_compiled_permits")
        end

        # @stanislaw: this needs revision!

        alias_method :"#{type}_rules", :"#{type}_compiled_permits"
      end
=end
      def save! permits
        super
        save_permits(permits) if permits

        File.open(file_path, 'w') do |f|
          f.write to_yaml
        end
      end

      def save_permits permits
        load_from_hash permits
      end

      protected

      def to_yaml
        permit_types.inject({}) do |collection, type|
          collection.merge(send(:"#{type}_permits_to_hash"))
        end.to_yaml.gsub(/"(@\w+)"/,'\1') # hash.to_yaml leaves quotes on strings prefixed with @
      end

      def loader
        @loader ||= CanTango::PermitStore::Loader::Yaml.new file_path
      end

      protected

      def permit_types
        CanTango.config.permits.types.registered
      end

      def file_path
        File.join(path, file_name)
      end

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
end