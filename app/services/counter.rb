class Counter
  include Singleton

  attr_writer :product_count

  def product_count
    @product_count ||= Product.count
  end
end