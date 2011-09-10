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

## How to Use It

### Use the Cue Module, Directly

It has methods for splitting up text:

```ruby
require 'cue'

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

Blocks are optional on all of them:

```ruby
Cue.each_ngram("hey you guys", 2)

# returns:
["hey you", "you guys"]
```

### Mix-in Cue::StringExtensions

Extend a string with Cue::StringExtensions, and it'll have those
methods:

```ruby
require 'cue'

motto = "I came. I saw. I hacked."
motto.extend(Cue::StringExtensions)
motto.each_sentence do |sentence|
  puts sentence
end

# prints:
I came.
I saw.
I hacked.

motto.each_word.to_a.uniq #=> ["I", "came", "saw", "hacked"]
```

### Make a Cue::String

Cue::String includes Cue::StringExtensions, but delegates everything
else to its string. It's like mixing Cue::StringExtensions into your
own string.

```ruby
require 'cue'

littany = Cue::String.new("I must not fear.")
littany.each_ngram(3) do |ngram|
  puts ngram
end

# prints:
I must not
must not fear
```

### StringExtensions For Everybody!

If you're feeling generous, code(require 'cue/core_ext') mixes
Cue::StringExtensions into the core String class, so **everyone** can
enjoy it.

```ruby
require 'cue/core_ext'

"Fear is the mind-killer.".each_word.to_a

# returns:
["Fear", "is", "the", "mind-killer"]
```

### Future Plans

- Stop words! These are totally missing from the wrapper right now.
- code(Cue.each_ngram) currently yields whole strings - maybe split
  them into Arrays of words.
