require 'spec_helper'

describe FormObjectModel::Field do
  context "when self responds to has_value?" do
    before do
      subject.stub(:respond_to?).with(:has_value?).and_return(true)
      subject.should_receive(:has_value?).with("A value").and_return(true)
    end

    describe "==" do
      it "calls has_value? with its argument" do
        (subject == "A value").should be_true
      end
    end

    describe "!=" do
      it "calls has_value? with its argument" do
        (subject != "A value").should be_false
      end
    end
  end

  context "when self does not respond to has_value?" do
    before do
      subject.stub(:respond_to?).with(:has_value?).and_return(false)
    end

    describe "== method" do
      it "behaves in the conventional way" do
        (subject == "A value").should be_false
      end
    end

    describe "!= method" do
      it "behaves in the conventional way" do
        (subject != "A value").should be_true
      end
    end
  end
end
