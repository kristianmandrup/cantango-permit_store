module CanTango
  class Config
    module Ability
      class PermitStore < Engine
        def modes
          @modes ||= [:cache]
        end

        def store &block
          @store ||= ns::Store.new
          @store.default_class = CanTango::PermitStore::Yaml
          yield @store if block
          @store
        end

        def types
          [:roles, :role_groups, :licenses, :users, :user_types, :account_types]
        end

        attr_reader :config_path

        def config_path path = nil
          return current_config_path if !path
          raise "Must be a valid path to permission yaml file, was: #{path}" if !dir?(path)
          @config_path = path
        end

        alias_method :config_path=, :config_path

        private

        def valid_mode_names
          [:cache, :no_cache]
        end

        def current_config_path
          @config_path ||= File.join(::Rails.root.to_s, 'config') if rails?
          @config_path or raise "Define path to config files dir!\nCanTango.config.engine(:permission).config_path(dir_path)"
        end

        def rails?
          defined?(::Rails) && ::Rails.respond_to?(:root)
        end

        def dir? dir
          return false if !dir
          File.directory?(dir)
        end
      end
    end
  end
end
