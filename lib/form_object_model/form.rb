module FormObjectModel
  class Form
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
