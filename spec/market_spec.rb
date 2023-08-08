require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  it "Init and get data" do
    market = Market.new("South Pearl Street Farmers Market")
    expect(market.name).to eq("South Pearl Street Farmers Market")
    expect(market.vendors).to eq([])

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])

    expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
    expect(market.vendors_that_sell(item4)).to eq([vendor2])

    expect(vendor1.potential_revenue).to eq(29.75)
    expect(vendor2.potential_revenue).to eq(345.00)
    expect(vendor3.potential_revenue).to eq(48.75)
  end

  it "market total inv, overstocked, sorted list" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    result = {
       item4 => {:quantity=>50, :vendors=>[vendor2]},
       item3 => {:quantity=>25, :vendors=>[vendor2]},
       item2 => {:quantity=>7, :vendors=>[vendor1]},
       item1 => {:quantity=>100, :vendors=>[vendor1, vendor3]},
    }

    expect(market.item_total_stock(item1)).to eq(100)
    expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    expect(market.total_inventory).to eq(result)
    expect(market.overstocked_items).to eq([item1])

    vendor2.stock(item2, 50)
    expect(market.overstocked_items).to eq([item2, item1])
  end

  it "date and selling items" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.date).to eq(Date.today)

    # old_date = double('date')
    # old_date.stub(:date).and_return('27/04/1985')
    # market.get_date

    expect(market.sell(item3, 50)).to eq(false)
    # expect(market.sell(item1, 50)).to eq(true)

  end
end