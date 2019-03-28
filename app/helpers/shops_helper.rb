module ShopsHelper
  def change_currency_on locale, cash
    return t :free unless cash.present?
    locale == Settings.en ? convert_to_american(cash) : convert_to_vietnam(cash)
  end

  def total_cost_of locale, cart
    total_cost = 0
    cart.each{|product| total_cost += product.price.to_i}
    change_currency_on locale, total_cost
  end

  private

  def convert_to_american cash
    number_to_currency cash
  end

  def convert_to_vietnam cash
    cash = cash.to_i
    number_to_currency cash * Settings.currency
  end
end
