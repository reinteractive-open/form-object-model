# FormObjectModel

[![Build Status](https://secure.travis-ci.org/reinteractive-open/form-object-model.png?branch=master)](http://travis-ci.org/reinteractive-open/form-object-model)

This gem lets you construct an object model
of a form you're using in your request specs.
With a form object model, locators and field types
are defined in a single place so if the form structure
changes your test don't need to change, only the
definition of the form fields.

So given the following form in a page:

```html
<form action="/foo">
  <label for="name">Name</label>
  <input type="text" name="name" id="name" />

  <label for="title">Title</label>
  <select id="title" name="title">
    <option>Mr</option>
    <option>Miss</option>
    <option>Mrs</option>
  </select>

  <h3>Gender</h3>
  <label for="gender_male">Male</label>
  <input type="radio" name="gender" value="male" id="gender_male" />

  <label for="gender_female">Female</label>
  <input type="radio" name="gender" value="female" id="gender_female" />
</form>
```

Forms are defined like so:

```ruby
form = FormObjectModel.new do |fom|
  form.text_field :name, "Name"
  form.select     :title, "Title"
  form.radio      :gender, "input[name = gender]"
end
```

You can then set the value of the fields, in a consistent way, regardless of the field type. This is like so:

```ruby
form.name  = "Joe Bloggs"
form.title = "Mr"
form.gender = "Male"
``` 

And assert the field value using:

```ruby
form.name.should have_value("Joe Bloggs")
form.title.should have_value("Mr")
form.gender.should have_value("Male")
```

## TODOs

* Support more field types, currently just handle, text, select and radio buttons.
* Make it easier to define custom field types for custom widgets.

## Installation

Add this line to your application's Gemfile:

    gem 'form_object_model'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install form_object_model

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

