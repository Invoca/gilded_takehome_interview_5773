# frozen_string_literal: true

require_relative './items/item'
require_relative './items/fine_art'
require_relative './items/concert_ticket'
require_relative './items/gold_coin'

class Inventory
  def initialize(items)
    @items = items
  end

  def change_item_price_and_sell_by
    @items.each(&:change_item_price_and_sell_by)
  end
end
