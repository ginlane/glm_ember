require 'spec_helper'
require 'fileutils'
describe GlmEmber::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before :each do
    GlmEmber::Generators::InstallGenerator.any_instance.stubs(:update_bundle)
    GlmEmber::Generators::InstallGenerator.any_instance.stubs(:run_ember_files_and_update)
    GlmEmber::Generators::InstallGenerator.any_instance.stubs(:install_teaspoon)
    prepare_destination
  end

  after :each do
    prepare_destination
  end

  context "Blank" do
    before :each do
      run_generator %w[ -A ]
    end

    it "should append gems to the Gemfile" do
      destination_root.should have_structure {
        file "Gemfile" do
          contains 'gem "ember-rails"'
          contains 'gem "guard"'
          contains 'gem "teaspoon"'
          contains 'gem "guard-teaspoon"'
        end
      }
    end
  end

  context "Engine" do
    before :each do
      run_generator %w[ --engine FnordEngine -A ]
    end

    it "should have a .gemspec" do
      destination_root.should have_structure {
        file "fnord_engine.gemspec" do
          contains 's.add_dependency "ember-rails"'
          contains 's.add_dependency "guard"'
          contains 's.add_dependency "teaspoon"'
          contains 's.add_dependency "guard-teaspoon"'
        end
      }
    end
  end

  context "Existing file" do
    before :each do
      File.open "#{destination_root}/Gemfile", "w+" do |f|
        f.write "gem 'something'\n"
      end
      run_generator
    end
    it "should return the right ember bootstrap options" do
      generator.send(:ember_bootstrap_opts).should eql "-g --javascript-engine coffee  --app-name App"
    end
    it "should be fine if Gemfile exists" do
      destination_root.should have_structure {
        file "Gemfile" do
          contains 'gem "ember-rails"'
          contains 'gem "guard"'
          contains 'gem "teaspoon"'
          contains 'gem "guard-teaspoon"'
        end
      }
    end
  end
end
