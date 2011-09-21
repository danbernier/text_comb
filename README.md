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

### It's All In the TextComb Module

There are methods for splitting up text:

```ruby
require 'text_comb'

string = "He must be a little nuts. He is. I mean he just isn't well
          screwed on is he?"

p TextComb.words(string).to_a

# prints:
["He", "must", "be", "a", "little", "nuts", "He", "is", "I", "mean"...

TextComb.sentences(string).each do |sentence|
  p sentence
end

# prints:
"He must be a little nuts. "
"He is. "
"I mean he just isn't well screwed on is he?"

TextComb.ngrams(string, 5).each do |ngram|
  p ngram
end

# prints:
"He must be a little"
"must be a little nuts"
"I mean he just isn't"
...
```

TextComb can take a guess at the language, and use the appropriate stop-words:

```ruby
string = "That's a great mustache, grandma!"
TextComb.ngrams(string, 2, :stop_words=>:guess).to_a

# returns:
["great mustache", "mustache grandma"]
```

If it picks wrong, and you know what you're dealing with, you can specify:

```ruby
TextComb.ngrams(string, 3, :stop_words=>:Croatian).each do |ngram|
  puts ngram
end
```

If you're curious, TextComb will tell you how it guessed:

```ruby
string = "J'ai la moutarde dans ma moustache."
TextComb.guess_language(string).to_s   # "French"
```

### Mix-in TextComb::StringExtensions

Extend a string with TextComb::StringExtensions, and it'll have those
methods:

```ruby
require 'text_comb'

motto = "I came. I saw. I hacked."
motto.extend(TextComb::StringExtensions)

motto.sentences.to_a    # ["I came. ", "I saw. ", "I hacked."]
motto.words.to_a.uniq   # ["I", "came", "saw", "hacked"]
```

Stop-words for n-grams work the same way, too.

```ruby
string = "I saw red roosters at Ted's farm."
string.extend(TextComb::StringExtensions)
string.ngrams(2, :stop_words => :English).to_a

# returns:
["saw red", "red roosters", "Ted's farm"]
```

### Make a TextComb::String

TextComb::String includes TextComb::StringExtensions, but delegates everything
else to its string. It's like mixing TextComb::StringExtensions into your
own string.

```ruby
require 'text_comb'

littany = TextComb::String.new("I must not fear.")
littany.ngrams(3).to_a   # ["I must not", "must not fear"]
```

Even handier, there's the TextComb.string method to save you some 
finger-tapping.

```ruby
require 'text_comb'
littany = TextComb.string("I must not fear.")
littany.words.to_a  # -> ["I", "must", "not", "fear."]

littany.guess_language.to_s  # -> :English
```

### Future Plans

- code(TextComb.ngrams) currently yields whole strings - maybe split
  them into Arrays of words.
