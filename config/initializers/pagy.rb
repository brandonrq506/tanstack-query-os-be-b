# frozen_string_literal: true

require "pagy/extras/overflow"
# Sensible defaults for API consumers (Pagy 9 naming)
Pagy::DEFAULT[:limit] = 20               # default per-page size
Pagy::DEFAULT[:max_items] = 100          # upper bound to prevent abuse
Pagy::DEFAULT[:limit_param] = :per_page  # accept `per_page` instead of default
Pagy::DEFAULT[:overflow] = :last_page
