require 'fileutils'
module GlmEmber
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path "../", __FILE__

      desc "Installs Specific Ember, QUnit, and Teaspoon test runners for a Rails app"

      class_option :engine, type: :string, default: nil
      class_option :app_name, type: :string, default: "App"

      def append_gems
        if options[:engine]
          file_name  = "#{options[:engine].tableize.singularize}.gemspec"
          gem_prefix = "s.add_dependency"
        else
          file_name  = "Gemfile"
          gem_prefix = "gem"
        end


        append_file file_name, <<-EOS

#{gem_prefix} "ember-rails"
#{gem_prefix} "guard"
#{gem_prefix} "teaspoon"
#{gem_prefix} "guard-teaspoon"

        EOS
      end

      def update_bundle
        run "bundle"
      end

      def update_guardfile
        append_file "Guardfile", <<-'EOS'

guard :teaspoon do
  watch(%r{app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }
  watch(%r{test/javascripts/(.*)})
end
        EOS
      end

      def run_ember_files_and_update
        run "bundle exec rails g ember:bootstrap #{ember_bootstrap_opts}"
      end

      def install_teaspoon
        run "bundle exec rails g teaspoon:install --framework=qunit --coffee"
      end

      protected
      def ember_bootstrap_opts
        engine_path = options[:engine].try(:tableize).try :singularize
        path        = engine_path ? "--ember-path app/assets/javascripts/#{engine_path}" : ""
        app         = options[:engine] || options[:app_name]
        "-g --javascript-engine coffee #{path} --app-name #{app}"
      end
    end
  end
end
