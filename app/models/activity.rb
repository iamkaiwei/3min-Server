class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user
  belongs_to :sender, class_name: User

  def display_image_url
    if subject.respond_to?(:product)
      display_image = subject.product.images.first
      display_image.content.url(:thumb) if display_image
    end
  end
end
