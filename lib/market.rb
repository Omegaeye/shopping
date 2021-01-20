
class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name        = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_quantity(item)
  @vendors.map do |vendor|
  vendor.check_stock(item)
    end.sum
  end

  def quantity_and_vendors_hash(item)
    total = Hash.new
      total[:quantity]  = total_quantity(item)
      total[:vendors]   = vendors_that_sell(item)
    total
  end

  def total_inventory
    hash = Hash.new
    @vendors.flat_map do |vendor|
      vendor.inventory.find_all do |item, quantity|
        hash[item] = quantity_and_vendors_hash(item)
      end
    end
    hash
  end

  def list_of_all_items
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item|
        item
      end
    end
  end

  def overstocked_items
    array = []
    @vendors.flat_map do |vendor|
      vendor.inventory.find_all do |item, quantity|
    return array << item if total_quantity(item) > 50 && vendors_that_sell(item).length > 1
      end
    end
  end

  def sorted_item_list
    sorted = []
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, quantity|
        sorted << item.name
      end.flatten
    end.uniq.sort
  end

  def sell(item, quantity)
    if !total_inventory[item] || total_inventory[item][:quantity] < quantity
      return false
    end
  end

end
