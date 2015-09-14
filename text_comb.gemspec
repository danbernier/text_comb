require_relative "lib/text_comb/version"

spec = Gem::Specification.new do |s|
  s.name = 'text_comb'
  s.version = TextComb::VERSION

  s.summary = %{
    Extract words, sentences, and n-grams from natural-language text.
  }.strip

  s.description = %{A Ruby wrapper for the cue.language java library.}

  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb'] + %w[
    README.md
    Rakefile
    text_comb.gemspec
    vendor/cue.language.jar
  ]

  s.require_path = 'lib'
  s.platform = 'java'
  s.required_ruby_version = ">= 1.9.2"

  s.author = "Dan Bernier"
  s.email = "danbernier@gmail.com"
  s.homepage = "https://github.com/danbernier/text_comb"
end
