require_relative "lib/textcomb/version"

spec = Gem::Specification.new do |s|
  s.name = 'textcomb'
  s.version = Textcomb::VERSION

  s.summary = %{
    Extract words, sentences, and n-grams from natural-language text.
  }.strip

  s.description = %{A Ruby wrapper for the cue.language java library.}

  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb'] + %w[
    README.md
    Rakefile
    textcomb.gemspec
    bin/cue.language.jar
  ]

  s.require_path = 'lib'
  s.required_ruby_version = ">= 1.9.2"

  s.author = "Dan Bernier"
  s.email = "danbernier@gmail.com"
  s.homepage = "https://github.com/danbernier/s9-e1"
end
