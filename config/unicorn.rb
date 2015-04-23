app_path = "/home/apps/rails_projects/asthma2015/current"
rails_env = ENV["RAILS_ENV"] || "production"

preload_app true
working_directory app_path
pid "#{app_path}/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/log/unicornerr.log"
stdout_path "#{app_path}/log/unicornout.log"

listen 5012, :tcp_nopush => false

# 这里设置监听地址，将与nginx配置关联
listen "/tmp/unicorn.asthma2015.sock"
worker_processes 6
timeout 120

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  old_pid = "#{app_path}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end