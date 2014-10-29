class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user, counter_cache: true
  belongs_to :sender, class_name: User

  TYPE = {
    chat: 1,
    offer: 2,
    like: 3,
    follow: 4,
    comment: 5,
    feedback: 6
  }

  def display_image_url
    if subject.respond_to?(:product)
      display_image = subject.product.images.first
      display_image.content.url(:thumb) if display_image
    end
  end
end
