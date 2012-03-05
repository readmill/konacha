require 'spec_helper'

describe "konacha/specs/index" do
  let(:dependency) { asset_double("dependency") }

  it "renders a script tag for each spec in @specs" do
    assign(:specs, [spec_double("a_spec"),
                    spec_double("b_spec")])

    render

    rendered.should have_selector("script[src='/assets/a_spec.js?body=1']")
    rendered.should have_selector("script[src='/assets/b_spec.js?body=1']")
  end

  it "renders a script tag for a spec's dependencies" do
    assign(:specs, [spec_double("spec", [dependency])])

    render

    rendered.should have_selector("script[src='/assets/dependency.js?body=1']")
    rendered.should have_selector("script[src='/assets/spec.js?body=1']")
  end

  it "renders only one script tag for common dependencies" do
    assign(:specs, [spec_double("a_spec", [dependency]),
                    spec_double("b_spec", [dependency])])

    render

    rendered.should have_selector("script[src='/assets/dependency.js?body=1']", :count => 1)
  end
end
