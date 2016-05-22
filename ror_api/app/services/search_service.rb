class SearchService

  def initialize(q)
    @q = q
  end

  def find
    query = "%#{@q}%"
    
    Merchant.includes(:products)
      .where("merchants.name ILIKE ? or products.name ILIKE ?", query, query)
      .references(:products)

    # Merchant.joins("LEFT OUTER JOIN products ON products.merchant_id = merchants.id and (merchants.name LIKE '#{query}' or products.name LIKE '#{query}')")

  end
end