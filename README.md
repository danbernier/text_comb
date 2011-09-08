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

### Future Plans

- Create a module you can mix into a String, so you can call those
  methods on it.
- Let you extend all String classes with the module, if that's what
  you're into. Something like code(require 'cue/core_ext').
- code(Cue.each_ngram) currently yields whole strings - maybe split
  them into Arrays of words.