defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  @doc """
    Creates a set of strings to represent a pack of cards

    Examples

      iex> Cards.create_deck

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "four", "five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    # Rather than using a 2 dimensional array
    # we can assign this in one loop, that will iterate through
    # every possible combination
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  @doc """
    Shuffles a given set of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  @doc """
    Checks if a `card` is in the deck

    Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
    # String.contains?(card, deck)
  end
  @doc """
    Provides a set of cards based on the `hand_size`
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
  @doc """
    Save cards to file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
  @doc """
    loads cards from file
  """
  def load(filename) do
    # Compare and assignment in one statement
    # _reason tells Elixir that we do not want to utilise the
    # error reason, or another variable. This allows us to skip
    # the core pattern matching logic within Elixir.
    case File.read(filename) do
      {:ok, binary } -> :erlang.binary_to_term binary
      {:error, _reason } -> "That file does not exist"
    end
  end
  @doc """
    Creates a hand based on various methods within module
  """
  def create_hand(hand_size) do
    # The pipe expects you to keep
    # your arguments required
    # by the following methods
    # in the first arg
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
