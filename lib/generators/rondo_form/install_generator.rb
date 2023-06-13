module RondoForm
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      desc "This generator installs the javascript needed for rondo_form"

      def copy_the_javascript
        copy_file "cocoon_controller.js", "app/javascript/controllers/cocoon_controller.js", force: true
        if (Rails.root.join("app/javascript/controllers/index.js")).exist?
          append_to_file "app/javascript/controllers/index.js", 
            %(import CocoonController from "./cocoon_controller"\napplication.register("cocoon", CocoonController)\n)
        else
          say %(Couldn't find "app/javascript/controllers/index.js".), :red
        end
      end
    end
  end
end