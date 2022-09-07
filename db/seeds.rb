# frozen_string_literal: true

john = User.create!(name: 'John', email: 'john@example.com')
susie = User.create!(name: 'Susie', email: 'susie@example.com')

hannibal = Party.create!(movie_id: 1, start_time: '2022-12-25 06:30:00 UTC', duration: 90, movie_title: "hannibal")
tombstone = Party.create!(movie_id: 2, start_time: '2022-12-31 12:00:00 UTC', duration: 120, movie_title: "tombstone")

PartyUser.create!(party: hannibal, user: john, host: true)
PartyUser.create!(party: hannibal, user: susie, host: false)
PartyUser.create!(party: tombstone, user: susie, host: true)
PartyUser.create!(party: tombstone, user: john, host: false)
