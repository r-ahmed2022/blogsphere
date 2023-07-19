# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.new(
    name: 'Riyaz',
    photo: 'riyaz.jpg',
    bio: 'Teacher from India'
  )
  user.skip_confirmation! # If you have email confirmation enabled in Devise
  user.save!
 post = Post.create(
    title: 'Demo Post',
    text: 'This is demo for render site',
    author: user
)

comment = Comment.create(
    text: 'This is a comment for the default post.',
    post: post,
    author: user
  )
  

user.posts << post
user.comments << comment
