# FormObjectModel

This gem lets you construct an object model
of a form you're using in your request specs.
With a form object model, locators and field types
are defined in a single place so if the form structure
changes your test don't need to change, only the
definition of the form fields.

Forms are defined like so:

  form = FormObjectModel.new do |fom|
    fom.text_field :field_name, "css locator for field"
  end

You can the field the field using:

  form.field_name = "Value"

And assert the field value using:

  form.field_name.should have_value("Value")

## Installation

Add this line to your application's Gemfile:

    gem 'form_object_model'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install form_object_model

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
