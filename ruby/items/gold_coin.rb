# frozen_string_literal: true

require_relative 'item'

class GoldCoin < Item
  MAX_ITEM_PRICE = 80

  def change_item_price_and_sell_by
    # gold coins never decrease in price
  end
end
