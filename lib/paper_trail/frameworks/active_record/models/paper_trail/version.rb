# frozen_string_literal: true

require "paper_trail/version_concern"

module PaperTrail
  # This is the default ActiveRecord model provided by PaperTrail. Most simple
  # applications will only use this and its partner, `VersionAssociation`, but
  # it is possible to sub-class, extend, or even do without this model entirely.
  # See the readme for details.
  class Version < ::ActiveRecord::Base
    include PaperTrail::VersionConcern

    def friendly_item_type
      friendly_item_type_from_class(self.class)
    end

    def self.friendly_item_type_from_class(klass)
      # Skip past all classes with a nil version_friendly_name
      while klass.version_friendly_name.nil?
        superklass = klass.superclass
        break if superklass.nil?
        klass = superklass
      end
      friendly_name = klass.version_friendly_name
      friendly_name = friendly_name.call(klass) if friendly_name.is_a?(Proc)
      friendly_name = friendly_name.dup
      # Go through all superclasses until we reach the top
      root_model_names = PaperTrail.config.root_model || []
      root_model_names = [root_model_names] unless root_model_names.is_a?(Array)
      root_model_names = (root_model_names + [::ActiveRecord::Base]).map(&:name)
      until (klass = klass.superclass).name.nil? || root_model_names.include?(klass.name)
        suffix = klass.version_friendly_suffix || klass.name.split('::').last.titleize
        friendly_name << ' ' + suffix unless suffix.blank?
      end
      friendly_name
    end
  end
end
