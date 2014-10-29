class Counter
  include Singleton

  def increase_product_count
    @product_count += 1
  end

  def decrease_product_count
    @product_count -= 1
  end

  def product_count
    @product_count ||= Product.count
  end
end