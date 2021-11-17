require_relative 'store'

def main
  cart = Store::Cart.new
  cart.process
  discount = Store::Discount.new(cart.item_list)
  discount.calculate_discount
  invoice = Store::Invoice.new(cart.item_list, discount, '$')
  invoice.print_invoice
  begin
rescue => e
    puts "Error: #{e}"
  end
end

main()
