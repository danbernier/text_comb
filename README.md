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

string = "He must be a little nuts. He is. I mean he just isn't well
          screwed on is he?"

p Cue.words(string).to_a

# prints:
["He", "must", "be", "a", "little", "nuts", "He", "is", "I", "mean"...

Cue.sentences(string).each do |sentence|
  p sentence
end

# prints:
"He must be a little nuts. "
"He is. "
"I mean he just isn't well screwed on is he?"

Cue.ngrams(string, 5).each do |ngram|
  p ngram
end

# prints:
"He must be a little"
"must be a little nuts"
"I mean he just isn't"
...
```

Cue can take a guess at the language, and use the appropriate stop-words:

```ruby
string = "That's a great mustache, grandma!"
Cue.ngrams(string, 2, :stop_words=>:guess).to_a

# returns:
["great mustache", "mustache grandma"]
```

If it picks wrong, and you know what you're dealing with, you can specify:

```ruby
Cue.ngrams(string, 3, :stop_words=>:Croatian).each do |ngram|
  puts ngram
end
```

If you're curious, Cue will tell you how it guessed:

```ruby
string = "J'ai la moutarde dans ma moustache."
Cue.guess_language(string).to_s   # "French"
```

### Mix-in Cue::StringExtensions

Extend a string with Cue::StringExtensions, and it'll have those
methods:

```ruby
require 'cue'

motto = "I came. I saw. I hacked."
motto.extend(Cue::StringExtensions)

motto.sentences.to_a    # ["I came. ", "I saw. ", "I hacked."]
motto.words.to_a.uniq   # ["I", "came", "saw", "hacked"]
```

Stop-words for n-grams work the same way, too.

```ruby
string = "I saw red roosters at Ted's farm."
string.extend(Cue::StringExtensions)
string.ngrams(2, :stop_words => :English).to_a

# returns:
["saw red", "red roosters", "Ted's farm"]
```

### Make a Cue::String

Cue::String includes Cue::StringExtensions, but delegates everything
else to its string. It's like mixing Cue::StringExtensions into your
own string.

```ruby
require 'cue'

littany = Cue::String.new("I must not fear.")
littany.ngrams(3).to_a   # ["I must not", "must not fear"]
```

### StringExtensions For Everybody!

If you're feeling generous, code(require 'cue/core_ext') mixes
Cue::StringExtensions into the core String class, so **everyone** can
enjoy it.

```ruby
require 'cue/core_ext'

"Fear is the mind-killer.".words.to_a   # ["Fear", "is", "the", "mind-killer"]
```

### Future Plans

- code(Cue.ngrams) currently yields whole strings - maybe split
  them into Arrays of words.
