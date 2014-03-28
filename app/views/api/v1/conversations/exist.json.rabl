object @conversation

attributes :id, :product_id, :offer, :channel_name

child(@recipient) { attributes :id, :full_name, :facebook_avatar }