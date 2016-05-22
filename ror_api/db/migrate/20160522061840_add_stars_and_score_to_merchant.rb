class AddStarsAndScoreToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :stars, :integer, default: 0
    add_column :merchants, :rate_score, :float, default: 0
  end
end
