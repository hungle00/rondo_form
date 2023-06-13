# frozen_string_literal: true
require_relative "rondo_form/version"
require_relative "rondo_form/view_helpers"

module RondoForm
  class Engine < ::Rails::Engine
    # configure our plugin on boot
    initializer "rondo_form.initialize" do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, RondoForm::ViewHelpers
      end
    end

  end
end
