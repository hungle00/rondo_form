module RondoForm
  module ViewHelpers

    # this will show a link to remove the current association. This should be placed inside the partial.
    # either you give
    # - *name* : the text of the link
    # - *f* : the form this link should be placed in
    # - *html_options*:  html options to be passed to link_to (see <tt>link_to</tt>)
    #
    # or you use the form without *name* with a *&block*
    # - *f* : the form this link should be placed in
    # - *html_options*:  html options to be passed to link_to (see <tt>link_to</tt>)
    # - *&block*:        the output of the block will be show in the link, see <tt>link_to</tt>

    def link_to_remove_association(*args, &block)
      if block_given?
        f            = args.first
        html_options = args.second || {}
        name         = capture(&block)
        link_to_remove_association(name, f, html_options)
      else
        name, f, html_options = *args
        html_options ||= {}

        is_dynamic = f.object.new_record?
        html_options[:class] = [html_options[:class], "remove_fields #{is_dynamic ? 'dynamic' : 'existing'}"].compact.join(' ')
        html_options[:'data-action'] = "click->nested-rondo#removeField"
        f.hidden_field(:_destroy) + link_to(name, '', html_options)
      end
    end

    # shows a link that will allow to dynamically add a new associated object.
    #
    # - *name* :         the text to show in the link
    # - *f* :            the form this should come in
    # - *association* :  the associated objects, e.g. :tasks, this should be the name of the <tt>has_many</tt> relation.
    # - *html_options*:  html options to be passed to <tt>link_to</tt> (see <tt>link_to</tt>)
    # - *&block*:        see <tt>link_to</tt>

    def link_to_add_association(*args, &block)
      if block_given?
        f, association, html_options = *args
        html_options ||= {}
        link_to_add_association(capture(&block), f, association, html_options)
      else
        name, f, association, html_options = *args
        html_options ||= {}

        html_options[:class] = [html_options[:class], "add_fields"].compact.join(' ')
        html_options[:'data-association'] = association.to_s.singularize
        html_options[:'data-associations'] = association.to_s.pluralize
        html_options[:'data-action'] = "click->nested-rondo#addField"

        new_object = f.object.class.reflect_on_association(association).klass.new
        model_name = new_object.class.name.underscore
        hidden_div = content_tag("template", id: "#{model_name}_fields_template", data: {'nested-rondo_target': 'template'}) do
          render_association(association, f, new_object, html_options)
        end
        hidden_div.html_safe + link_to(name, '', html_options )
      end
    end

    # :nodoc:
    def render_association(association, f, new_object, html_options)
      partial_name = html_options[:partial_name] || association.to_s.singularize + "_fields"
      f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(partial_name, :f => builder, :dynamic => true)
      end
    end
  end
end
