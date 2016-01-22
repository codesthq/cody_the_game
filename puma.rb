environment = ENV['RACK_ENV'] || 'staging'

root = "#{Dir.getwd}"

rackup "#{root}/config.ru"

bind "unix://#{root}/tmp/sockets/puma.sock"
pidfile "#{root}/tmp/pids/puma.pid"
state_path "#{root}/tmp/pids/puma.state"

threads 4, 8
workers 1

daemonize true

stdout_redirect "#{root}/log/puma.stdout.log", "#{root}/log/puma.stderr.log"
