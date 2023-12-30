# RondoForm

Handle dynamic nested forms, same as Cocoon, but using StimulusJS

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rondo_form

Or inside the Gemfile add the following

    $ gem 'rondo_form', '~> 0.2.3'

Run the installation task:

    $ rails g rondo_form:install 

## Usage

For example, we have `Project` model, which has `has_many` relationship with `Task` model:
```
rails g scaffold Project name:string description:string
rails g model Task description:string done:boolean project:belongs_to
```

### Sample with SimpleForm
In your `projects/_form` partial:
``` erb
<%= simple_form_for(@project) do |f| %>

  <div class="form-inputs">
    <%= f.input :name %>
    <%= f.input :description %>
  </div>

  <h3 class="text-xl mt-4">Tasks</h3>
  <div class="my-2" data-controller="nested-rondo" data-nested-rondo-field-class-value="task-field">
    <div data-nested-rondo-target="fieldContain">
      <%= f.simple_fields_for :tasks do |task| %>
        <%= render "task_fields", f: task %>
      <% end %>
    </div>
    <div class="links">
      <%= link_to_add_association "Add Task", f, :tasks %>
    </div>
  </div>

  <div class="form-actions mt-4">
    <%= f.button :submit %>
  </div>
<% end %>

```

In your `_task_fields` partial:
``` erb
<div class="task-field">
  <%= f.input :description %>
  <%= f.input :done, as: :boolean %>
  <%= link_to_remove_association "Remove Task", f %>
</div>

```

_Note_:
- Stimulus controller is `nested-rondo`, so you need to declare the element with `data-controller="nested-rondo"`.
- You must add `data-nested-rondo-target="fieldContain"`  to an element, that wraps all nested fields, the new field will be appended to this element.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hungle00/rondo_form.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
