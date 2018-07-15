# frozen_string_literal: true

require_relative '../migration_generator'

      # check_class_collision suffix: 'JobTest'

module PaperTrail
  # Updates STI entries for PaperTrail
  class UpdateStiGenerator < MigrationGenerator

    source_root File.expand_path("templates", __dir__)

    desc "Generates (but does not run) a migration to update item_type for STI entries in an "\
      "existing versions table."

    def create_migration_file
      add_paper_trail_migration("update_versions_for_sti", sti_type_options: options)
    end
  end
end
