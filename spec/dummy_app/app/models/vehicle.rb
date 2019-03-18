# frozen_string_literal: true

class Vehicle < ActiveRecord::Base
  # This STI parent class specifically does not call `has_paper_trail`.
  # Of its sub-classes, only `Car` and `Bicycle` are versioned.

  # For those two versioned types, their friendly type names get suffixed such that they become "Car Transpo"
  # and "Bicycle Transpo"
  update_paper_trail friendly_suffix: "Transpo"

  if ActiveRecord.gem_version >= Gem::Version.new("5.0")
    belongs_to :owner, class_name: "Person", optional: true
  else
    belongs_to :owner, class_name: "Person"
  end
end
