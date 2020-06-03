# frozen_string_literal: true

require_relative 'support/router.rb'
require_relative 'support/views.rb'

# next step: implement second framework + framework choice option
# next step: move methods into support folder/file

gems
overwrite_layout

after_bundle do
  homepage_controller
  homepage_view
  generate_installs_and_migrate
  git_ignore
  commit_and_push
end
