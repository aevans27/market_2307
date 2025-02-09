class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    value = 0
    @inventory.each do |k,v|
      if k == item
       value = v
      end
    end
    value
  end

  def stock(item, amount)
    if @inventory[item] == nil
      @inventory[item] = amount
    else
      @inventory[item] += amount
    end
  end

  def potential_revenue
    @inventory.sum do |k, value|
      k.price * value
    end
  end
end