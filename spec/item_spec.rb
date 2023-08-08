require './lib/item'

RSpec.describe Item do
  it "Init and get data" do
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    expect(item1.name).to eq("Peach")
    expect(item2.price).to eq(0.5)
  end
end