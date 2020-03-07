defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length = 20
  end
  test "shuffles cards" do
    deck = Cards.create_deck
    deck_shuffled = Cards.shuffle(deck)
    refute deck == deck_shuffled
  end

end
