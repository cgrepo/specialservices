# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
OtherExpediture.create! [
    {name:'COKE',amount:3720.23,expediture_id:23},
    {name:'BIT',amount:5789,expediture_id:23},
    {name:'VGAMES',amount:4593,expediture_id:23},
    {name:'IFD',amount:394,expediture_id:23},
    {name:'LIQ',amount:459,expediture_id:23},
    {name:'RANDOM',amount:3412,expediture_id:23}
    ]
# OtherService.create! [
#     {name:'SKY',living_place_id:10},
#     {name:'NETFLIX',living_place_id:10},
#     {name:'BLIM',living_place_id:10},
#     {name:'DRGSNNUTS',living_place_id:10},
#     {name:'BITXHSNPARROTS',living_place_id:10}
#     ]
# Benefit.create! [
#     {name:'COKE',amount:3720.23,person_id:265},
#     {name:'BIT',amount:5789,person_id:265},
#     {name:'VGAMES',amount:4593,person_id:265},
#     {name:'IFD',amount:394,person_id:265},
#     {name:'LIQ',amount:459,person_id:265},
#     {name:'RANDOM',amount:3412,person_id:265}
#     ]