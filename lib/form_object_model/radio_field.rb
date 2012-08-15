module FormObjectModel
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
end

