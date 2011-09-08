# Integration Exercise: Java Library Wrapper

## Exercise Summary

- You should create a gem using JRuby that wraps an existing Java library.
- Your gem should work with a Java library that doesn't already have
  a good wrapper.
- You should make the API for your library look and feel like Ruby, not Java.

## Wrapping cue.language

For this assignment, I'm wrapping the
[cue.language](https://github.com/vcl/cue.language) library, which
handles "counting strings, identifying languages, and removing stop
words."

### Currently
#### Cue Module
I have a Cue module, with three methods:

```ruby
Cue.each_word(string) do |word|
  puts word
end

Cue.each_sentence(string) do |sentence|
  puts sentence
end

Cue.each_ngram(string, 3) do |ngram|
  puts ngram
end
```

Each has a simple unit test you can run via code(rake) or code(rake
test).

#### Cue::StringExtensions

Extend a string with Cue::StringExtensions, and it'll have those
methods:

```ruby
motto = "I came. I saw. I hacked."
motto.extend(Cue::StringExtensions)
motto.each_sentence do |sentence|
  puts sentence
end

# prints:
I came.
I saw.
I hacked.
```

#### Cue::String

You can instantiate a Cue::String with a normal string, and get the
same effect.

```ruby
littany = Cue::String.new("I must not fear.")
littany.each_ngram(3) do |ngram|
  puts ngram
end

# prints:
I must not
must not fear
```

### Future Plans

- Let you extend all Strings with Cue::StringExtensions, if that's
  what you're into. Something like code(require 'cue/core_ext').
- Stop words! These are totally missing from the wrapper right now.
- code(Cue.each_ngram) currently yields whole strings - maybe split
  them into Arrays of words.