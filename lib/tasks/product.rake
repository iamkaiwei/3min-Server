namespace :product do
  desc "randomly like the user post from Kaiwei account 1 to 3 days after he post"
  task like: :environment do
    kaiwei = User.find_by_email("iamkaiwei@gmail.com")
    if kaiwei
      product = Product.recently(Time.now).limit(100).where.not(user_id: kaiwei.id).to_a.sample
      if product
        Like.create_and_increase_product_likes(user_id: kaiwei.id, product_id: product.id)
        Urbanairship.push(aliases: [product.user.alias_name], aps: { alert: "#{kaiwei.full_name} liked your product '#{product.name}'",
                                                                     badge: 1, sound: "default", other: { product_id: product.id } })
      end
    end
  end
end
