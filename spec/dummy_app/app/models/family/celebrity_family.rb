# frozen_string_literal: true

module Family
  class CelebrityFamily < Family::Family
    # Normally the friendly name would end up "Celebrity Family Family" unless we shorten our friendly name
    # to simply "Celebrity"
    update_paper_trail friendly_name: "Celebrity"
  end
end
