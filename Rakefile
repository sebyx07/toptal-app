dirs = %w(backend)

task :stop do
  sh 'docker stop $(docker ps -a -q)'
end

task :setup do
  sh 'docker-compose build'
  sh 'docker-compose run backend bash /app/shell/db_reset.sh'
  sh 'docker-compose run backend bash /app/shell/install_frontend.sh'
  sh 'docker-compose run ws shards'
end

task :db_reset do
  sh 'docker-compose run backend bash /app/shell/db_reset.sh'
end


dirs.each do |dir|
  namespace dir do
    task :chown do
      sh "sudo chown $USER #{dir} -R"
    end
  end
end

task 'file_watchers' do
  sh 'echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf'
  sh 'sudo sysctl -p'
end