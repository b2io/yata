namespace :ci do
  task :travis do
    puts "Running rspec specs..."
    system("export DISPLAY=:99.0 && bundle exec rake rspec specs")
    raise "rspec failed!" unless $?.exitstatus == 0
  end
end