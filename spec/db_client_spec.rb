require 'rspec'

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'todo/model/DbClient'

def insert_todo_item(id, text)
  DbClient.instance.client.insert(
    :todo_items,
    id,
    {'item_text' => text, 'done' => '0'}
  )
end

describe 'DB Client' do

  it "is a singleton" do
    expect { DbClient.new }.to raise_error(NoMethodError)
  end

  it "inserts todo items" do
    client = DbClient.instance.client
    item_text = 'Brew some coffee'
    item_id = "1"
    insert_todo_item(item_id, item_text)
    expect(client.get(:todo_items, item_id)["item_text"]).to eq(item_text)
  end

  it "removes todo items" do
    client = DbClient.instance.client
    item_id = "1"
    expect(client.get(:todo_items, item_id)).not_to be_empty
    client.remove(:todo_items, item_id)
    expect(client.get(:todo_items, item_id)).to be_empty
  end

  it "retrieves todo items" do
    client = DbClient.instance.client
    item_1_text = "brew coffee"
    item_2_text = "brew more coffee"
    insert_todo_item("1", item_1_text)
    insert_todo_item("2", item_2_text)
    items = client.get_range(:todo_items, :key_count => 2)
    expect(items["1"]["item_text"]).to eq(item_1_text)
    expect(items["2"]["item_text"]).to eq(item_2_text)
  end

  it "updates todo items" do
    client = DbClient.instance.client
    insert_todo_item("1", "brew coffee")
    expect(client.get(:todo_items, "1")["item_text"]).to eq("brew coffee")
    insert_todo_item("1", "drink water")
    expect(client.get(:todo_items, "1")["item_text"]).to eq("drink water")
  end
end
