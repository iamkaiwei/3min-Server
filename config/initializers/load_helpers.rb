Dir.glob("#{Rails.root}/lib/helpers/*_helper.rb").each do |file_name|
	require file_name[0..-4]
end
