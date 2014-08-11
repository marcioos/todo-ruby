class TodoItem
  attr_accessor :text, :done
  attr_reader :id

  def initialize(db_record = nil)
    if db_record
      @id = db_record["id"]
      @text = db_record["item_text"]
      @done = !db_record["done"].to_i.zero?
    else
      @id = nil
      @text = ""
      @done = false
    end
  end

  def self.find_by_id(id)
    self.new(DbClient.instance.client.get(:todo_items, id))
  end

  def save
    DbClient.instance.client.insert(
      :todo_items,
      @id or self.generate_id,
      {'item_text' => @text, 'done' => @done ? '1' : '0'})
  end

  def self.generate_id
    # TODO
  end
end
