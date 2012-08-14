module FormObjectModel
  module Helper
    def have_value(value)
      FormObjectHaveValueMatcher.new(value)
    end
  end
end

