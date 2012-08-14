require "spec_helper"

describe FormObjectModel do
  let(:page) { Capybara::Session.new(:rack_test, @app) }
  after { page.reset! }

  before(:all) do
    @app = lambda do |env|
      if env['REQUEST_METHOD'] == 'POST'
        body = <<-HTML
          <html>
            <head>
            </head>
            <body>
              <p>Submitted</p>
            </body>
          </html>
        HTML
      else
        body = <<-HTML
          <html>
          <head>
          </head>
          <body>
            <form action="/" method="post">
              <label for="textfield1">Text Field 1</label>
              <input type="text" id="textfield1" name="textfield1" />

              <label for="selectfield1">Select Field</label>
              <select id="selectfield1">
                <option>Option 1</option>
                <option>Option 2</option>
                <option>Option 3</option>
              </select>

              <label for="radio1">Radio 1"</label>
              <input type="radio" name="radio" id="radio1" value="Radio1"/>
              <label for="radio2">Radio 2"</label>
              <input type="radio" name="radio" id="radio2" value="Radio2"/>
              <label for="radio3">Radio 3"</label>
              <input type="radio" name="radio" id="radio3" value="Radio3"/>

              <input type="submit" name="submit" value="Submit" />
            </form>
          </body>
        </html>
        HTML
      end
      [200,
        { 'Content-Type' => 'text/html',
          'Content-Length' => body.length.to_s },
          [body]]
    end
  end

  let(:form) do
    FormObjectModel::Form.new(page) do |f|
      f.text_field :textfield1, "Text Field 1"
      f.select :selectfield1, "Select Field"
      f.radio  :radiobuttons1, "input[name = radio]"
      f.submit_button "Submit"
    end
  end

  before { page.visit("/") }

  context "text fields" do
    it "should set the value of the field" do
      form.textfield1 = "My Value"
      page.should have_field("Text Field 1", :with => "My Value")
    end

    it "should fail when the value of the field is different" do
      page.fill_in("Text Field 1", :with => "A value")
      lambda { form.textfield1.should have_value("Other value") }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "should pass when the value of the field is the same" do
      page.fill_in("Text Field 1", :with => "A value")
      form.textfield1.should have_value("A value")
    end
  end

  context "single select" do
    it "should set the value of the field" do
      form.selectfield1 = "Option 2"
      page.should have_select("Select Field", :selected => "Option 2")
    end

    it "should fail when set to another value" do
      page.select("Option 3", :from => "Select Field")
      lambda { form.selectfield1.should have_value("Option 2") }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "should pass with the value is the same" do
      page.select("Option 2", :from => "Select Field")
      form.selectfield1.should have_value("Option 2")
    end
  end

  context "radio buttons" do
    it "should set the radio button via its label" do
      form.radiobuttons1 = "Radio 2"
      page.should have_checked_field("radio2")
    end

    it "should set the radio button via the other label" do
      form.radiobuttons1 = "Radio 3"
      page.should have_checked_field("radio3")
    end

    it "should fail when the radio button is set to another value" do
      page.choose("radio2")
      lambda { form.radiobuttons1.should have_value("Radio 1") }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "should pass when the radio button is set to the same value" do
      page.choose("radio3")
      form.radiobuttons1.should have_value("Radio 3")
    end
  end

  context "submit" do
    it "should submit the form" do
      form.submit
      page.should have_content("Submitted")
    end

    context "with a submit callback" do
      let(:form) do
        FormObjectModel::Form.new(page) do |f|
          f.submit_button "Submit" do
            page.should have_content("Submitted")
            @callback_fired = true
          end
        end
      end

      it "should call the callback after submission" do
        form.submit
        @callback_fired.should be_true
      end
    end

    context "without submit defined" do
      let(:form) do
        FormObjectModel::Form.new(page)
      end

      it "should raise an error on submission" do
        lambda { form.submit }.should raise_error
      end
    end
  end
end

