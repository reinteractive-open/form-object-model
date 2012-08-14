

# This class lets you construct an object model
# of a form you're using in your request specs.
# With a form object model, locators and field types
# are defined in a single place so if the form structure
# changes your test don't need to change, only the
# definition of the form fields.
#
# Forms are defined like so:
#
# form = FormObjectModel.new do |fom|
#   fom.text_field :field_name, "css locator for field"
# end
#
# You can the field the field using:
#
#   form.field_name = "Value"
#
# And assert the field value using:
#
#   form.field_name.should have_value("Value")
#
module FormObjectModel
  class Form
    Field = Struct.new(:page, :name, :locator)
    class TextField < Field
      def fill(value)
        page.fill_in(locator, :with => value.to_s)
      end

      def has_value?(value)
        page.has_field?(locator, :with => value.to_s)
      end

      def value
        page.find_field(locator).value
      end
    end

    class SelectField < Field
      def fill(value)
        page.select(value.to_s, :from => locator)
      end

      def has_value?(value)
        page.has_select?(locator, :selected => value.to_s)
      end

      def value
        value = nil
        page.within(page.find_field(locator)) do
          value = page.find("option[selected]").text
        end
        value
      end
    end

    class RadioField < Field
      # This lets you select the radio button by it's label instead of id
      def fill(value)
        if button = button_for(value)
          button.set(true)
        else
          raise "Could not find button with locator '#{locator}' and label '#{value}'"
        end
      end

      def has_value?(value)
        button = button_for(value)
        button && %w(checked true).include?(button['checked'])
      end

      def value
        element = checked_element
        element && element.value
      end

      private
      def checked_element
        page.all(locator).find {|b| b['checked'] == 'checked' }
      end

      def button_for(value)
        label_ids = label_ids_for(value)
        page.all(locator).find {|b| label_ids.include?(b['id']) }
      end

      def label_ids_for(value)
        page.all("label:contains('#{value}')").map {|label| label['for'] }
      end
    end

    attr_reader :page

    def initialize(page)
      @page = page
      yield(self) if block_given?
    end

    def text_field(name, locator)
      define_field(name, TextField.new(page, name, locator))
    end

    def select(name, locator)
      define_field(name, SelectField.new(page, name, locator))
    end

    # Radio button locators should match all buttons in the group
    def radio(name, locator)
      define_field(name, RadioField.new(page, name, locator))
    end

    def submit_button(locator, &after_submit_block)
      @submit_button = locator
      @after_submit_block = after_submit_block
    end

    def submit
      raise "FormObjectModel#submit_button called before submit_button locator was set" unless @submit_button
      page.click_button @submit_button
      if @after_submit_block
        @after_submit_block.call(page)
      end
    end

    def within
      yield(self)
    end

    private

    def define_field(name, field)
      (class << self; self; end).class_eval do
        define_method(name) {|*args| field }
        define_method("#{name.to_s}=".to_sym) {|val| field.fill(val) }
      end
    end
  end
end

