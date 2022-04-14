class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    @foods = Food.left_outer_joins(:orders).where(order_foods:{food_id: nil}).distinct
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    #@shops = Shop.left_outer_joins(:foods)←各料理を提供しているお店
    @shops = Shop.left_outer_joins(foods: :orders).where(order_foods:{food_id: nil}).distinct
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    #order_idを持ったaddress群が出てくる
    #@address = Address.joins(:orders)←address_idが多いものを表示したい
    #@address = Address.joins(:orders).group(:id).maximum(:id).count←address_idが一番多いもののid
    @address = Address.joins(:orders).select("addresses.*, count(orders.address_id) AS orders_count").group(:id).order('count(address_id) desc').first
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    #@customer = Customer.joins(:orders)←orderをした顧客
    @customer = Customer.joins(orders: :foods).select("customers.*,sum(foods.price) AS foods_price_sum").group(:id).order('sum(price) desc').first
  end
end