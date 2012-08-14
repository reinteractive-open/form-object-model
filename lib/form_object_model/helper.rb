module FormObjectModel
  module FormObjectHelpers
    def have_value(value)
      FormObjectHaveValueMatcher.new(value)
    end
  end
end

