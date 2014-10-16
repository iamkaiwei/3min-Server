collection @feedbacks

attributes :id, :content, :status

child(:product) do
  attributes :id, :name
end

child(:sender) do
  attributes :id, :full_name, :avatar
end