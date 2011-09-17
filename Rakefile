require 'rake'

task :default => :test

desc "Run all the tests"
task :test do
  $LOAD_PATH.push './lib'
  Dir.glob('test/test*.rb').each { |f| require f }
end
