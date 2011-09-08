require 'rake'

task :default => :test

task :test do
  require 'test/unit'
  $LOAD_PATH.push './lib'
  require *Dir.glob('test/*.rb')
end