module FormObjectModel
  class FormObjectHaveValueMatcher < Struct.new(:value)
    attr_reader :actual

    def matches?(actual)
      @actual = actual
      actual.has_value?(value)
    end

    def failure_message_for_should
      "Expected field '#{actual.locator}' to have value '#{value}' but had '#{actual.value}'"
    end
  end
end

