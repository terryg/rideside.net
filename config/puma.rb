# frozen_string_literal: true

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

port        ENV['PORT']     || 4567
environment ENV['RACK_ENV'] || 'development'

# The app is preloaded, so ROM/Sequel open DB connections in the master. A TLS
# session can't be shared across forked workers ("bad record mac"), so drop
# them here and let each worker reconnect lazily.
before_fork do
  MAIN_CONTAINER.gateways[:default].connection.disconnect
end

on_worker_boot do
  # Worker specific setup
end
