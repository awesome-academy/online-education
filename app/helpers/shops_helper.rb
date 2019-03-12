module ShopsHelper
  def change_currency_on locale, cash
    return t(:free) unless cash.present?
    locale == "en" ? convert_to_american(cash) : convert_to_vietnam(cash)
  end

  private

  def convert_to_american cash
    number_to_currency cash
  end

  def convert_to_vietnam cash
    cash = cash.to_i
    number_to_currency(cash * Settings.currency)
  end
end
