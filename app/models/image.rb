class Image < ActiveRecord::Base
	belongs_to :attachable, :polymorphic => true

	has_attached_file :content, :styles => { :small => "150x150>", :thumb => "100x100>", :square => "200x200#", :medium => "300x300>" }

	validates_attachment_size :content, :less_than => 2.megabytes
	validates_attachment_content_type :content, :content_type => %W(image/jpeg image/png)
	validates_presence_of :content
end
