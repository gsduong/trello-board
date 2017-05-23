# create users
users_data = [
  { email: 'minh@gmail.com', password: '12345678', password_confirmation: '12345678', bio: 'Handsome', full_name: 'Minh' },
  { email: 'duong@gmail.com', password: '12345678', password_confirmation: '12345678', bio: 'Pretty', full_name: 'Duong' },
  { email: 'linh@gmail.com', password: '12345678', password_confirmation: '12345678', bio: 'Gay', full_name: 'Linh' },
  { email: 'phung@gmail.com', password: '12345678', password_confirmation: '12345678', bio: 'Beautiful', full_name: 'Phung' },
  { email: 'ha@gmail.com', password: '12345678', password_confirmation: '12345678', bio: 'Les', full_name: 'Ha' }
]

users = users_data.reduce({}) do |result, user_data|
  result[user_data[:email]] = User.create(user_data)
  result
end

# create board
board = Board.create(
  name: 'ICT Family Chores',
  description: 'Chores manager for ICT family'
)

# add all users to board
users.map do |(key, user)|
  BoardMember.create(board: board, member: user)
end

# create lists
lists_data = [
  { board: board, title: 'Chore List', position: 1 },
  { board: board, title: 'In Progress', position: 2 },
  { board: board, title: 'Finished', position: 3 }
]

lists = lists_data.reduce({}) do |result, list_data|
  result[list_data[:title]] = List.create(list_data)
  result
end

# create cards
cards_data = [
  { list: lists['Chore List'], title: 'mow the lawn', position:  1, assignee: users['minh@gmail.com'] },
  { list: lists['Chore List'], title: 'take out the trash', position:  2, assignee: users['minh@gmail.com'] },
  { list: lists['Chore List'], title: 'animal rights rally', position:  3, assignee: users['phung@gmail.com'] },
  { list: lists['Chore List'], title: 'write itchy & scratchy complaint letter', position: 4, assignee: users['duong@gmail.com'] },
  { list: lists['In Progress'], title: 'drink beer and watch tv', position: 1, assignee: users['minh@gmail.com'] },
  { list: lists['In Progress'], title: 'saxophone practice', position: 2, assignee: users['phung@gmail.com'] },
  { list: lists['Finished'], title: 'do not have a cow', position: 1, assignee: users['linh@gmail.com'] },
  { list: lists['Finished'], title: 'make pancakes!', position: 2, assignee: users['duong@gmail.com'] },
  { list: lists['Finished'], title: 'shoot mr. burns', position: 3, assignee: users['ha@gmail.com'] },
]

cards = cards_data.reduce({}) do |result, card_data|
  result[card_data[:title]] = Card.create(card_data)
  result
end

# create card comments
card_comments_data = [
  { card: cards['saxophone practice'], commenter: users['duong@gmail.com'], content: 'your playing sounds great lisa! :)' },
  { card: cards['write itchy & scratchy complaint letter'], commenter: users['linh@gmail.com'], content: '¡ay, caramba! but, mom, this is my favorite show!' },
  { card: cards['shoot mr. burns'], commenter: users['duong@gmail.com'], content: 'i know this was only an accident maggie. :(' },
  { card: cards['take out the trash'], commenter: users['duong@gmail.com'], content: 'homer, honey, the trash is overflowing, please take it out soon.' },
  { card: cards['make pancakes!'], commenter: users['phung@gmail.com'], content: 'they were delicious!' },
  { card: cards['animal rights rally'], commenter: users['phung@gmail.com'], content: 'please comment here if you would like to join me.' },
  { card: cards['make pancakes!'], commenter: users['minh@gmail.com'], content: 'thanks marge. :)' }
]

card_comments_data.map { |comment| CardComment.create(comment) }
