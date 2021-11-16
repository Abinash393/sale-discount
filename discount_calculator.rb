require_relative 'store'

def main
  begin
    bill1 = Store::Checkout.new(Store::Cart.new.process, '$')
    bill1.calculate_discount
    bill1.print_invoice
  rescue => e
    puts "Error: #{e}"
  end
end

main()
