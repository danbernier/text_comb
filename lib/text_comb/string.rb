require 'delegate'

module TextComb

  class String < DelegateClass(::String)
    include StringExtensions
  end

end
