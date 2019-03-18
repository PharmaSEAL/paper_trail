# frozen_string_literal: true

require "spec_helper"

RSpec.describe Vehicle, type: :model do
  it { is_expected.not_to be_versioned }

  it "should utilise the suffix properly" do
    # Although Vehicle is not audited, the class name is still used when determining the friendly type name.
    # We've overriden the normal name of "Vehicle" instead to be "Transpo".
    expect(PaperTrail::Version.friendly_item_type_from_class(Car)). to eq("Car Transpo")
    expect(PaperTrail::Version.friendly_item_type_from_class(Bicycle)). to eq("Bicycle Transpo")
  end
end
