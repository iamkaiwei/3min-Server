object @conversation

attributes :id, :product_id, :offer, :channel_name

child(@recipient) { attributes :id, :full_name, :avatar, :facebook_avatar }