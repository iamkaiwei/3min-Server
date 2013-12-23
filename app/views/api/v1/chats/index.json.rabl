collection @chats
attributes *ProductsChat.column_names

node(:message) { |pc| pc.chat.message }

