## Learning

### Docs

https://elixir-lang.org/docs.html

### Best practices

- Use double quotes rather than single (both can be used, but the convention is double)
- Always delegate to existing methods (e.g. use pre-written native methods rather than duplication, writing your own)
- hand_size underscores for methods and vars (appears to be the common convention)
- Think of = as pattern matching at all times (and when the left is not defined, it assigns the value to the given name. The same in any language)
- If statements are not recommended

### Conventions

- Functional programming, rather than OOP with Elixir
- Focus on functional methodology, e.g. a method has an input and produces an output. In this case, methods all return a value. You don't need to declare a variable and point out what to return.
- OOP, would have a class instance, where you can update its entity e.g. new card class... card.shuffle etc. 
Where you can get its properties from the class object.
- Functional, does not have a class, it can drive methods but it is stateless. You therefore manage the data by using methods, storing the data, then playing it back against other methods e.g. shuffleCards, however the data is not bound to a specific class.

- Arity refers to the number of arguments a method excepts

### CLI

`iex -S mix` - Run App from CLI
`recompile`  - recompile application 

Cards - will return the card module object

Cards.hello - will trigger the hello method from the cards module

Cards.create_deck

## Utils / Lang

EnumView Source
Provides a set of algorithms to work with enumerables.

`Enum.shuffle(["hello", "cat"])`

The Shuffle method, copies the list, then shuffles the list, and returns a new copy. This is of great importance, that no data mutation should occur.

A way to detect if an array contains a string
`String.contains?(card, deck)`

Another way to do this is with 
`Enum.member?(deck, card)`

## Module

````

  defmodule Cards do
    def create_deck do
      ["Ace", "Two", "Three"]
    end
    def shuffle(deck) do
      Enum.shuffle(deck)
    end
    def contains(card, deck) do
      String.contains?(card, deck)
    end
  end

````

Elixir, inside a method, as we don't have return definitions, the method will return the last value inside.

e.g. 

`['a']`
`['b']`
`['c']`

C will be returned.

Iteration

````

  suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
      for suit <- suits do
        'hello'
      end

  // will return ['hello', 'hello', 'hello', 'hello']

````

Not the way

`````
  for value <- values do
    for suit <- suits do
      "#{value} of #{suit}"
    end
  end
````

[
  ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds"],
  ["Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds"],
  ["Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds"],
  ["four of Spades", "four of Clubs", "four of Hearts", "four of Diamonds"], 
  ["five of Spades", "five of Clubs", "five of Hearts", "five of Diamonds"]
]

A simple fix is, `List.flatten(cards)`

This is an elegant way of gaining the same output:

````
  for suit <- suits, value <- values do
    "#{value} of #{suit}"
  end
````

Here we only want an output of one list, so we can create one list / loop, that wil derive every combination possible.

A tuple is an array, with a special meaning. Where the developer builds a list of elements e.g. string, []
and the they knows that index 0 is a ref and the second value is the list that refers to the ref.

`Enum.split(deck, hand_size)`

returns

`{["a"], ["b", "c"]}`

Retrieve data from a tuple

````
{ type, hand } = Cards.deal(["a","b","c"], 1)

````

access values 

`type` would be 'A' the card delt
`hand` remaining cards

Code > Elixir > (transpiled) > Erlang >(compiled and executed) > BEAM

### Relationship between Elixir and Erlang

Erlang Abstract Machine, like a JVM.

https://www.erlang.org/

### Error handling

````
  def load(filename) do
    {status, binary} = File.read(filename)
    case status do
      :ok -> :erlang.binary_to_term binary
      :error -> "That file does not exist"
    end
  end

  and a simplified version:

  def load(filename) do
    case File.read(filename) do
      {:ok, binary } -> :erlang.binary_to_term binary
      {:error, reason } -> "That file does not exist"
    end
  end

````

:ok is an atom. Elixir uses them to help the control flow of a system.

:error - is also an atom.

````

// will not work
["red", color] = ["green", "blue"]

// will work
["red", "blue"] = ["green", "blue"]

````

### Functional programming

````
  
  def create_hand(hand_size) do
    deck = Cards.create_deck
    deck = Cards.shuffle(deck)
    hand = Cards.deal(deck, hand_size)
  end

  and with pipe

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

````

Install deps

````
  
  mix deps.get

````

ExDocs enables two types of documentation

Functions and modules.

Once you have written some annotations

run `mix docs` to generate the docs.

````

defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

````

For methods

@doc """
    Creates a hand based on various methods within module
  """

## Test

There are two types of test, assertion based testing and doc testing.

run `mix test` to run the tests

It also runs the example tests too.... crazy cray!

## Example of case test

test "create deck makes 20 cards" do
  deck_length = length(Cards.create_deck)
  assert deck_length = 20
end