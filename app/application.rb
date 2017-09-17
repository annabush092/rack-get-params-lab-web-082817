class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      resp.write read_cart
    elsif req.path.match(/add/)
      add_term = req.params["item"]
      resp.write add_to_cart(add_term)
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def read_cart
    if @@cart.length == 0
      "Your cart is empty\n"
    else
      @@cart.map do |cart_item|
         "#{cart_item}\n"
      end.join
    end
  end

  def add_to_cart(add_term)
    @@items.each do |item|
      if add_term == item
        @@cart << item
        return "added #{item} to cart."
      else
        return "We don't have that item"
      end
    end
  end

end
