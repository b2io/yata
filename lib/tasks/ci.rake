namespace :ci do
  task :travis do
    puts "Running rspec spec..."
    system("export DISPLAY=:99.0 && bundle exec rspec spec")
    raise "rspec failed!" unless $?.exitstatus == 0
  end
end