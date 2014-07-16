class Image < ActiveRecord::Base
	belongs_to :attachable, :polymorphic => true

	has_attached_file :content, :styles => { :small => "150x150>", :thumb => "100x100>", :square => "200x200#", :medium => "300x300>" }

	validates_attachment_size :content, :less_than => 2.megabytes
	validates_attachment_content_type :content, :content_type => %W(image/jpeg image/png)
	validates_presence_of :content

  before_save :extract_dimensions
  serialize :dimensions

  def extract_dimensions
    tempfile = content.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end
end
