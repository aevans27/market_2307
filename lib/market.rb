require 'date'

class Market
  attr_reader :name, :vendors, :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = []
    @vendors.each do |vendor|
      names << vendor.name
    end
    names
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    total_stock = []
    @vendors.each do |vendor|
      vendor.inventory.each do |k, v|
        total_stock << k.name
      end
    end
    total_stock.uniq.sort
  end

  def total_inventory
    total_stock = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |k,v|
        total_stock[k] = {
          quantity: item_total_stock(k),
          vendors: vendors_that_sell(k)
        }
      end
    end
    total_stock
  end

  def item_total_stock(item)
    stock = 0
    @vendors.each do |vendor|
      vendor.inventory.each do |k,v|
        if k == item
          stock += v
        end
      end
    end
    stock
  end

  def overstocked_items
    items = []
    item_hash = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |k,v|
        if item_hash[k] == nil
          item_hash[k] = v
        else
          item_hash[k] += v
          if item_hash[k] >= 50
            items << k
          end
        end
      end
    end
    items.uniq             
  end

  def get_date
    @date
  end

  def sell(item, amount)
    # left_over = 0
    if item_total_stock(item) < amount
      false
    # else
    #   @vendors.each do |vendor|
    #     vendor.inventory.each do |k, v|
    #       if item == k
    #         if v < amount && amount > left_over
    #           left_over = (amount - v)
    #           inventory[k] = 0
    #         else 
    #           inventory[k] -= amount
    #         end
    #       end
    #     end
    #   end
    end
  end
end