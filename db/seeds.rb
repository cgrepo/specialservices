# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
OtherExpediture.create! [
    {name:'COKE',amount:3720.23},
    {name:'BIT',amount:5789},
    {name:'VGAMES',amount:4593},
    {name:'IFD',amount:394},
    {name:'LIQ',amount:459},
    {name:'RANDOM',amount:3412}
    ]
OtherService.create! [
    {name:'SKY'},
    {name:'NETFLIX'},
    {name:'BLIM'},
    {name:'DRGSNNUTS'},
    {name:'BITXHSNPARROTS'}
    ]
Benefit.create! [
    {name:'COKE',amount:3720.23},
    {name:'BIT',amount:5789},
    {name:'VGAMES',amount:4593},
    {name:'IFD',amount:394},
    {name:'LIQ',amount:459},
    {name:'RANDOM',amount:3412}
    ]