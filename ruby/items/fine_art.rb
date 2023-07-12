# frozen_string_literal: true

require_relative 'item'

class FineArt < Item
  def change_item_price_and_sell_by
    @sell_by -= 1
    increase_price
    increase_price if past_sell_by_date?
  end
end
