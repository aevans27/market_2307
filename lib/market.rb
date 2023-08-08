class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
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
    vendors = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
        vendors << vendor
      end
    end
    vendors
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
end