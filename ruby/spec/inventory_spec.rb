# frozen_string_literal: true

require 'rspec'
require_relative '../inventory'

describe 'Inventory' do
  def add_item_and_update_price(item)
    inventory = Inventory.new([item])
    inventory.change_item_price_and_sell_by
    inventory.instance_variable_get(:@items).first
  end

  context 'for normal items' do
    it 'reduces price and sell_by' do
      item = add_item_and_update_price(Item.new('Normal Item', 10, 20))
      expect(item.sell_by).to eq(9)
      expect(item.price).to eq(19)
    end

    it 'reduces price twice as fast for items past sell_by' do
      item = add_item_and_update_price(Item.new('Normal Item', -1, 20))
      expect(item.price).to eq(18)
    end

    it 'does not allow price to go negative' do
      item = add_item_and_update_price(Item.new('Normal Item', 10, 0))
      expect(item.price).to eq(0)
    end
  end

  context 'for Fine Art items' do
    it 'increases price' do
      item = add_item_and_update_price(FineArt.new('Fine Art', 10, 20))
      expect(item.price).to eq(21)
    end

    it 'does not allow price to exceed 50' do
      fine_art_item = add_item_and_update_price(FineArt.new('Fine Art', 10, 50))
      expect(fine_art_item.price).to eq(50)
    end
  end

  context 'for Concert Tickets' do
    it 'increases price by 1 when more than 10 days before sell_by' do
      concert_tickets_item = add_item_and_update_price(ConcertTicket.new('Concert Tickets', 12, 20))
      expect(concert_tickets_item.price).to eq(21)
    end

    it 'increases price by 2 when between 6 and 10 days before sell_by' do
      concert_tickets_item = add_item_and_update_price(ConcertTicket.new('Concert Tickets', 7, 20))
      expect(concert_tickets_item.price).to eq(22)
    end

    it 'increases price by 3 when less than 6 days before sell_by' do
      concert_tickets_item = add_item_and_update_price(ConcertTicket.new('Concert Tickets', 5, 20))
      expect(concert_tickets_item.price).to eq(23)
    end

    it 'reduces price to 0 when sell_by is zero' do
      concert_tickets_item = add_item_and_update_price(ConcertTicket.new('Concert Tickets', 0, 20))
      expect(concert_tickets_item.price).to eq(0)
    end

    it 'does not allow the price to exceed 50' do
      concert_tickets_item = add_item_and_update_price(ConcertTicket.new('Concert Tickets', 10, 50))
      expect(concert_tickets_item.price).to eq(50)
    end
  end

  context 'for multiple items' do
    it 'updates the price' do
      items = [
        Item.new('Item 1', 10, 20),
        FineArt.new('Fine Art', 5, 30),
        ConcertTicket.new('Concert Tickets', 7, 40)
      ]

      inventory = Inventory.new(items)
      inventory.change_item_price_and_sell_by

      expect(items[0].price).to eq(19)
      expect(items[1].price).to eq(31)
      expect(items[2].price).to eq(42)
    end

    it 'reduces the sell_by value for items' do
      item = add_item_and_update_price(Item.new('Normal Item', 10, 20))
      expect(item.sell_by).to eq(9)
    end
  end

  context 'for gold coins' do
    it 'does not allow the price to exceed 80' do
      gold_coins_item = add_item_and_update_price(GoldCoin.new('Gold Coins', 10, 80))
      expect(gold_coins_item.price).to eq(80)
    end

    it 'does not reduce the sell_by time' do
      gold_coins_item = add_item_and_update_price(GoldCoin.new('Gold Coins', 10, 80))
      expect(gold_coins_item.sell_by).to eq(10)
    end
  end
end
