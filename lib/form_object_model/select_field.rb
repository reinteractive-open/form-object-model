module FormObjectModel
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
end

