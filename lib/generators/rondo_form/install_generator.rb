module RondoForm
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      desc "This generator installs the javascript needed for rondo_form"

      def copy_the_javascript
        copy_file "nested_rondo_controller.js", "app/javascript/controllers/nested_rondo_controller.js", force: true
        if (Rails.root.join("app/javascript/controllers/index.js")).exist?
          append_to_file "app/javascript/controllers/index.js", 
            %(import NestedRondoController from "./nested_rondo_controller"\napplication.register("nested-rondo", NestedRondoController)\n)
        else
          say %(Couldn't find "app/javascript/controllers/index.js".), :red
        end
      end
    end
  end
end