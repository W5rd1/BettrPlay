User.destroy_all

User.create!(email: "kemal@hotmail.com", username: "KemalRulez", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "5", bio: "blah", first_name: "Kemal", last_name: "Yucetin")
User.create!(email: "gareth@hotmail.com", username: "GarethCableGuy", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "4", bio: "blah", first_name: "Gareth", last_name: "Yoodle")
User.create!(email: "dave@hotmail.com", username: "Arsenal4Lyfe", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "4", bio: "blah", first_name: "Dave", last_name: "Gates")
User.create!(email: "maciek@hotmail.com", username: "Magic Maciek", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "4", bio: "blah", first_name: "Maciek", last_name: "Godfrey")
User.create!(email: "phelim@hotmail.com", username: "Phellama", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "4", bio: "blah", first_name: "Phelim", last_name: "Dunleavy")
User.create!(email: "ben@hotmail.com", username: "baranjerrrr", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "4", bio: "blah", first_name: "Ben", last_name: "Baranger")
User.create!(email: "arthur@gmail.com", username: "MrDesigner", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "2", bio: "blah", first_name: "Arthur", last_name: "Littmann")
User.create!(email: "michael@gmail.com", username: "FifaGod", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "3", bio: "blah", first_name: "Michael", last_name: "Eldred")
User.create!(email: "gamer@gmail.com", username: "Gamer4eva", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "3", bio: "blah", first_name: "John", last_name: "Doe")
User.create!(email: "console@gmail.com", username: "consolescrub", password: 123456, dob: Date.parse("2018-12-12"), region: "uk", rank: "3", bio: "blah", first_name: "Peter", last_name: "Parker")


Challenge.destroy_all

# Challenge.create!(host_gamertag: "123snipez", host_id: 1, game: "CS:GO", stake: 15, status: "Open", platform: "PS4", description: "blah")
# Challenge.create!(host_gamertag: "123sntpezs", host_id: 2, game: "CS:GO", stake: 10, status: "Open", platform: "PS4", description: "blah")
# Challenge.create!(host_gamertag: "123snoopez", host_id: 2, game: "COD", stake: 5, status: "Closed", platform: "PS4", description: "blah")
# Challenge.create!(host_gamertag: "123snissspez", host_id: 3, game: "COD", stake: 20, status: "Accepted", platform: "PS4", description: "blah")
# Challenge.create!(host_gamertag: "123snipcxcez", host_id: 3, game: "COD", stake: 205, status: "Closed", platform: "XBox", description: "blah")
# Challenge.create!(host_gamertag: "123366senipez", host_id: 4, game: "FIFA", stake: 33, status: "Open", platform: "XBox", description: "blah")
# Challenge.create!(host_gamertag: "123snipwwwdez", host_id: 4, game: "FIFA", stake: 12, status: "Open", platform: "XBox", description: "blah")
# Challenge.create!(host_gamertag: "123snidsffpez", host_id: 5, game: "FIFA", stake: 8, status: "Accepted", platform: "PC", description: "blah")
# Challenge.create!(host_gamertag: "123snipedfdz", host_id: 5, game: "FIFA", stake: 9, status: "Open", platform: "PC", description: "blah")
# Challenge.create!(host_gamertag: "123snipedsssz", host_id: 5, game: "FIFA", stake: 13, status: "Closed", platform: "PC", description: "blah")


Chatroom.destroy_all

# Chatroom.create!(sender_id: 1, receiver_id: 2)
# Chatroom.create!(sender_id: 3, receiver_id: 4)
# Chatroom.create!(sender_id: 5, receiver_id: 6)
# Chatroom.create!(sender_id: 7, receiver_id: 8)


Message.destroy_all

# Message.create!(user_id: 2, chatroom_id: 1, read: true, content: "blah blah blah")
# Message.create!(user_id: 3, chatroom_id: 2, read: true, content: "blah blah blah")
# Message.create!(user_id: 5, chatroom_id: 3, read: false, content: "blah blah")
# Message.create!(user_id: 7, chatroom_id: 4, read: false, content: "blah blah")


# Dispute.destroy_all

# Dispute.create!(date: Date.parse("2018-12-12"), description: "blah blah blah", solved: false, challenge_id: 1)
# Dispute.create!(date: Date.parse("2018-12-12"), description: "blah blah blah", solved: false, challenge_id: 2)
# Dispute.create!(date: Date.parse("2018-12-12"), description: "blah blah blah", solved: false, challenge_id: 3)
# Dispute.create!(date: Date.parse("2018-12-12"), description: "blah blah blah", solved: false, challenge_id: 4)


Chatroom.destroy_all

# Chatroom.create!(sender_id: 12, receiver_id: 1)
# Chatroom.create!(sender_id: 12, receiver_id: 1)
# Chatroom.create!(sender_id: 12, receiver_id: 1)
# Chatroom.create!(sender_id: 12, receiver_id: 1)


Message.destroy_all

# Message.create!(user_id: 1, chatroom_id: 1, read: true, content: "Lets play")
# Message.create!(user_id: 1, chatroom_id: 2, read: true, content: "Hellooooo?")
# Message.create!(user_id: 1, chatroom_id: 3, read: false, content: "oi!!")
# Message.create!(user_id: 1, chatroom_id: 4, read: false, content: "hellloooo?")



