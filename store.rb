module Store
  class Cart
    attr_accessor :items, :item_list
  
    def initialize
      @item_list = Hash.new(0)
    end
  
    def process
      get_items
      count_items
    end
  
    private
  
    def get_items
      puts 'Please enter all the items purchased separated by a comma'
      print '> '
      self.items = gets.chomp.split(',').map{ |item| item.strip.to_sym }
    end
  
    def count_items
      items.each do |item|
        self.item_list[item] += 1
      end
    end
  end

  class Discount
    attr_accessor :cart, :bill, :total, :saving

    def initialize(cart)
      @cart = cart
      @bill = Hash.new(0.00)
      @total = 0.00
      @saving = 0.00
    end

    def calculate_discount
      cart.each do |item, quantity|
        if sale_items[item] && quantity >= sale_items[item][:quantity]
          bill[item] += sale_items[item][:price]
          quantity -= sale_items[item][:quantity]
          @saving += (sale_items[item][:quantity] * unit_price[item]) - sale_items[item][:price]
          @total += sale_items[item][:price]
        end
        item_total = unit_price[item] * quantity.to_f
        self.bill[item] += item_total
        @total += item_total
      end
    end

    private

    def unit_price
      { banana: 0.99,
        apple: 0.89,
        bread: 2.17,
        milk: 3.97
      }
    end

    def sale_items
      { bread: { quantity: 3, price: 6.00},
        milk: { quantity: 2, price: 5.00}
      }
    end
  end

  class Invoice
    attr_reader :cart, :bill, :currency, :total, :saving

    def initialize(cart, discount, currency)
      @cart = cart
      @currency = currency
      @bill = discount.bill
      @total = discount.total
      @saving = discount.saving
    end

    def print_invoice
      puts "\n"
      puts "Item\t Unit price\t \tSale price"
      puts '-' * 37
      self.cart.each do |item, quantity|
        log = ""
        log << item.to_s.capitalize.ljust(10, ' ')
        log << quantity.to_s
        log << ' ' * 12
        log << currency
        log << bill[item].round(2).to_s
        puts log
      end
      puts "\n"
      puts "Total price : #{currency}#{total.round(2)}"
      puts "You saved #{currency}#{saving.round(2)} today."
    end
  end
end