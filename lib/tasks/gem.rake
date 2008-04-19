namespace :gem do
  desc "install a gem into vendor/gems"
  task :install do
    if ENV["name"].nil?
      STDERR.puts "Usage: rake gem:install name=the_gem_name"; exit 1
    end
    sh "gem install #{ENV['name']} --install-dir=vendor/gems --no-rdoc --no-ri"
  end
end
