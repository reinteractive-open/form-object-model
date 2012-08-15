module FormObjectModel
  # A module that defines the getter and setter for the field
  # properties of a form.
  class FieldModule < Module
    def initialize(name, field)
      define_method(name.to_sym) { |*args| field }
      define_method("#{name}=".to_sym) { |val| field.fill(val) }
    end
  end
end

