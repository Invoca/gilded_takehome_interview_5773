# frozen_string_literal: true

require_relative 'item'

class ConcertTicket < Item
  TEN_DAYS_TO_CONCERT = 10
  FIVE_DAYS_TO_CONCERT = 5
  def change_item_price_and_sell_by
    @sell_by -= 1
    increase_price if @sell_by >= 0

    increase_price if @sell_by <= TEN_DAYS_TO_CONCERT
    increase_price if @sell_by <= FIVE_DAYS_TO_CONCERT

    @price = 0 if past_sell_by_date?
  end
end
