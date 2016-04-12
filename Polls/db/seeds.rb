# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
user1 = User.create!(user_name: 'Graham')
user2 = User.create!(user_name: 'Louis')
user3 = User.create!(user_name: 'Dillan')
user4 = User.create!(user_name: 'Adam')

Poll.destroy_all
poll1 = Poll.create!(title: "our first poll", author_id: user1.id)
poll2 = Poll.create!(title: "our second poll", author_id: user1.id)
poll3 = Poll.create!(title: "our millionth poll", author_id: user2.id)

Question.destroy_all
question1 = Question.create!(poll_id: poll1.id, text: "What's your favorite color?")
question2 = Question.create!(poll_id: poll1.id, text: "What's your least favorite color?")
question3 = Question.create!(poll_id: poll2.id, text: "How do you like our poll?")
question4 = Question.create!(poll_id: poll2.id, text: "How do you dislike our poll?")
question5 = Question.create!(poll_id: poll3.id, text: "Isn't this better than poll 2?")
question6 = Question.create!(poll_id: poll3.id, text: "Isn't this worse than poll 2?")

AnswerChoice.destroy_all
answer1 = AnswerChoice.create!(question_id: question1.id, text: 'blue')
answer2 = AnswerChoice.create!(question_id: question1.id, text: 'red')
answer3 = AnswerChoice.create!(question_id: question1.id, text: 'black')
answer4 = AnswerChoice.create!(question_id: question1.id, text: 'green')

answer5 = AnswerChoice.create!(question_id: question2.id, text: 'blue')
answer6 = AnswerChoice.create!(question_id: question2.id, text: 'red')
answer7 = AnswerChoice.create!(question_id: question2.id, text: 'black')
answer8 = AnswerChoice.create!(question_id: question2.id, text: 'green')

answer9 = AnswerChoice.create!(question_id: question3.id, text: 'lots')
answer10 = AnswerChoice.create!(question_id: question3.id, text: 'somewhat')
answer11 = AnswerChoice.create!(question_id: question3.id, text: 'little')
answer12 = AnswerChoice.create!(question_id: question3.id, text: 'not')

answer13 = AnswerChoice.create!(question_id: question4.id, text: 'lots')
answer14 = AnswerChoice.create!(question_id: question4.id, text: 'somewhat')
answer15 = AnswerChoice.create!(question_id: question4.id, text: 'little')
answer16 = AnswerChoice.create!(question_id: question4.id, text: 'what?')

answer17 = AnswerChoice.create!(question_id: question5.id, text: 'yes')
answer18 = AnswerChoice.create!(question_id: question5.id, text: 'no')

answer19 = AnswerChoice.create!(question_id: question6.id, text: 'yes')
answer20 = AnswerChoice.create!(question_id: question6.id, text: 'no')

Response.destroy_all
response1 = Response.create!(user_id: user3.id, answer_choice_id: answer1.id)
response2 = Response.create!(user_id: user3.id, answer_choice_id: answer5.id)
response3 = Response.create!(user_id: user3.id, answer_choice_id: answer9.id)
response4 = Response.create!(user_id: user3.id, answer_choice_id: answer13.id)
response5 = Response.create!(user_id: user3.id, answer_choice_id: answer17.id)
response6 = Response.create!(user_id: user3.id, answer_choice_id: answer20.id)
response7 = Response.create!(user_id: user4.id, answer_choice_id: answer2.id)
response8 = Response.create!(user_id: user4.id, answer_choice_id: answer7.id)
response9 = Response.create!(user_id: user4.id, answer_choice_id: answer10.id)
response10 = Response.create!(user_id: user4.id, answer_choice_id: answer15.id)
response11 = Response.create!(user_id: user4.id, answer_choice_id: answer18.id)
response12 = Response.create!(user_id: user4.id, answer_choice_id: answer19.id)
