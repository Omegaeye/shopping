class Vendor

  attr_reader :name,
              :inventory


  def initialize(name)
    @name      = name
    @inventory = Hash.new
  end

  def check_stock(item)
    if !@inventory[item]
      @inventory[item] = 0
    else
      @inventory[item] = @inventory[item]
    end
  end

  def stock(item, quantity)
    if !@inventory[item]
      @inventory[item] = quantity
    else
      @inventory[item] += quantity
    end
  end

  def potential_revenue
    @inventory.map do |item, quantity|
      item.price * quantity
    end.sum
  end

end
