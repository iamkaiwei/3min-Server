collection @feedbacks

attributes :id, :content, :status

node(:update_time) { |feedback| feedback.updated_at.to_i }

child(:product) do
  attributes :id, :name
end

child(:sender) do
  attributes :id, :full_name, :avatar
end