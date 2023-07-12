# frozen_string_literal: true

class Item
  MAX_ITEM_PRICE = 50
  MIN_ITEM_PRICE = 0

  attr_accessor :name, :sell_by, :price

  def initialize(name, sell_by, price)
    @name = name
    @sell_by = sell_by
    @price = price
  end

  def change_item_price_and_sell_by
    self.sell_by -= 1
    decrease_price
    decrease_price if past_sell_by_date?
  end

  def increase_price
    @price += 1 if price < MAX_ITEM_PRICE
  end

  def decrease_price
    @price -= 1 if price > MIN_ITEM_PRICE
  end

  def past_sell_by_date?
    sell_by.negative?
  end

  def to_s
    "#{name}, #{sell_by}, #{price}"
  end
end
