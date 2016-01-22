lock '3.4.0'

set :application, 'CodyOnRails'
set :repo_url, 'git@github.com:adtaily/CodyOnRails.git'
set :deploy_to, '/apps/CodyOnRails'
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

set :linked_files, fetch(:linked_files, []) + %w[
  config/database.yml
  config/secrets.yml
  .env
]
set :linked_dirs, fetch(:linked_dirs, []) + %w[
  log
  tmp
  public
]

set :sockets_path, -> { shared_path.join('tmp/sockets/') }
set :pids_path, -> { shared_path.join('tmp/pids/') }

after "deploy:publishing", "deploy:restart"

# ================================================================
# RBENV
# ================================================================
set :rbenv_type, :user
set :rbenv_ruby, '2.2.4'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby}
set :rbenv_roles, :all

# ================================================================
# Bundler
# ================================================================
set :bundle_bins, fetch(:bundle_bins, [])
set :bundle_roles, :all
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_without, %w{development test}.join(' ')
set :bundle_flags, '--deployment'

# ================================================================
# HipChat
# ================================================================
set :hipchat_token, 'ef27025b8eeb2064777acddf8a8c34'
set :hipchat_room_name, 'CodyOnRails Development'
set :hipchat_announce, false
set :hipchat_color, 'green'
set :hipchat_failed_color, 'red'

# ================================================================
# Puma
# ================================================================
set :puma_roles, -> { :app }
set :puma_socket, -> { "unix://#{fetch(:sockets_path).join('puma.sock')}" }
set :pumactl_socket, -> { "unix://#{fetch(:sockets_path).join('pumactl.sock')}" }
set :puma_state, -> { fetch(:pids_path).join('puma.state') }
set :puma_log, -> { shared_path.join("log/puma-#{fetch(:stage)}.log") }
set :puma_flags, -> { nil }

# ================================================================
# Puma monit
# ================================================================

set :puma_conf, -> { current_path.join('puma.rb') }
set :puma_monit_bin, -> { "/usr/sbin/monit" }

Rake::Task["puma:restart"].clear
Rake::Task["puma:phased-restart"].clear
namespace :puma do
  # always perform phased-restarts (no downtime)
  %w[phased-restart restart].each do |command|
    desc "#{command} puma"
    task command do
      on roles (fetch(:puma_role)) do
        within current_path do
          with rack_env: fetch(:puma_env) do
            if test "[ -f #{fetch(:puma_pid)} ]" and test "kill -0 $( cat #{fetch(:puma_pid)} )"
              # NOTE pid exist but state file is nonsense, so ignore that case
              execute "kill -s USR1 $( cat #{fetch(:puma_pid)} )"
            else
              # Puma is not running or state file is not present : Run it
              execute :bundle, 'exec', :puma, "-C #{fetch(:puma_conf)}"
            end
          end
        end
      end
    end
  end
end
