require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  def remove_index 
    remove_file "public/index.html"
  end

  def run_blacklight_generator
    say_status("warning", "GENERATING BL", :yellow)       

    Bundler.with_unbundled_env do
      run "bundle install"
    end

    generate 'blacklight:install'
  end

  # Use the local blacklight-gallery assets rather than the published package
  def add_local_package
    return unless File.exist?('app/assets/stylesheets/application.bootstrap.scss')

    run "yarn add file:#{Blacklight::Gallery::Engine.root}"
  end

  def run_gallery_install
    generate 'blacklight_gallery:install'
  end

end
