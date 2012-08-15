module FormObjectModel
  class Field < Struct.new(:page, :name, :locator)
    def ==(other)
      if respond_to?(:has_value?)
        has_value? other
      else
        super
      end
    end
  end
end

