# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c1 = Cat.create(birth_date: "2015/01/20", color: 'black', name: 'jeff',
  sex: 'M', description: 'great cat')
c2 = Cat.create(birth_date: "2015/01/20", color: 'green', name: 'bob',
  sex: 'M', description: 'green cat')
c3 = Cat.create(birth_date: "2010/11/20", color: 'white', name: 'sally',
  sex: 'F', description: 'pretty cat')

crr1 = CatRentalRequest.create(cat_id: 1, start_date: "2016/12/1", end_date: "2016/12/31")
crr2 = CatRentalRequest.create(cat_id: 2, start_date: "2016/12/1", end_date: "2016/12/31", status: "APPROVED")
