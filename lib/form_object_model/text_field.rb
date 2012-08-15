module FormObjectModel
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
end

