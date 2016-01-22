# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require "capistrano/rails"

require 'capistrano/rbenv'
require 'capistrano/puma'
require 'hipchat/capistrano'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

before 'deploy:finished', 'save_revision' do
  on roles(:all) do
    within release_path do
      revision_info = capture("cd #{repo_path} && git log -1 HEAD --pretty='format:%h %ci'")
      execute :echo, "#{revision_info} >> REVISION"
    end
  end
end
