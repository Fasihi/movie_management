actor_list = [
  [ "Al Pacino", "He is a legendary actor having Italian descent.", "Male" ],
  [ "George Clooney", "He is a very graceful actor.", "Male" ],
  [ "Kit Harington", "He just came alive in season 6", "Male" ],
  [ "Angelina Jolie", "She is a fine actress.", "Female" ],
  [ "Scarlett Johansson", "She is an amazing actress.", "Female" ],
  [ "Meera", "Well, af korse.", "Female" ],
  [ "Shaan", "In the wrong place.", "Male" ]
]

actor_list.each do |name, biography, gender|
  Actor.create( name: name, biography: biography, gender: gender )
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
