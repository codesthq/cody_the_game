role :app, [ENV["ROLE_APP"]]
role :web, [ENV["ROLE_NAME"]]
role :db, [ENV["ROLE_DB"]]


set :keep_releases, 5
set :rails_env, 'production'
set :puma_env, 'production'

set :branch, ENV["BRANCH_NAME"] || "master"
