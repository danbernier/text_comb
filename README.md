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

### It's All In the Cue Module

There are methods for splitting up text:

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

Leave off the blocks, and get Enumerables:

```ruby
Cue.each_ngram("Hey you guys!", 2).to_a

# returns:
["Hey you", "you guys"]
```

Cue can take a guess at the language, and use the appropriate stop-words:
```ruby
string = "That's a great mustache, grandma!"
Cue.each_ngram(string, 2, :stop_words=>:guess).to_a

# returns:
["great mustache", "mustache grandma"]
```

If it picks wrong, and you know what you're dealing with, you can specify:
```ruby
Cue.each_ngram(string, 3, :stop_words=>:Croatian) do |ngram|
  puts ngram
end
```

If you're curious, Cue will tell you how it guessed:
```ruby
string = "J'ai la moutarde dans ma moustache."
Cue.guess_language(string).to_s => "French"
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

motto.each_word.to_a.uniq

# returns:
["I", "came", "saw", "hacked"]
```

Stop-words aren't supported in Cue::StringExtensions. Yet. YET.

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

- Get those stop-words on Cue::StringExtensions.
- code(Cue.each_ngram) currently yields whole strings - maybe split
  them into Arrays of words.
