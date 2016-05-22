class SearchService

  def initialize(q)
    @q = q
  end

  def find
    query = "%#{@q}%"
    
    Merchant.includes(:products)
      .where("merchants.name ILIKE ? or products.name ILIKE ?", query, query)
      .references(:products)
  end
end
