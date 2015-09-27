# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# SHARP => &#x266f;
# FLAT  => &#x266d;
	song_key = [
		["A", "A", "A", "", 0],
		["A<sup>&#x266f;</sup>", "A sharp", "A", "&#x266f;", 0],
		["A<sup>&#x266d;</sup>", "A flat",  "A", "&#x266d;", 0],
		["B", "B", "B", "", 0],
		["B<sup>&#x266f;</sup>", "B sharp", "B", "&#x266f;", 0],
		["B<sup>&#x266d;</sup>", "B flat",  "B", "&#x266d;", 0],
		["C", "C", "C", "", 0],
		["C<sup>&#x266f;</sup>", "C sharp", "C", "&#x266f;", 0],
		["C<sup>&#x266d;</sup>", "C flat",  "C", "&#x266d;", 0],
		["D", "D", "D", "", 0],
		["D<sup>&#x266f;</sup>", "D sharp", "D", "&#x266f;", 0],
		["D<sup>&#x266d;</sup>", "D flat",  "D", "&#x266d;", 0],
		["E", "E", "E", "", 0],
		["E<sup>&#x266f;</sup>", "E sharp", "E", "&#x266f;", 0],
		["E<sup>&#x266d;</sup>", "E flat",  "E", "&#x266d;", 0],
		["F", "F", "F", "", 0],
		["F<sup>&#x266f;</sup>", "F sharp", "F", "&#x266f;", 0],
		["F<sup>&#x266d;</sup>", "F flat",  "F", "&#x266d;", 0],
		["G", "G", "G", "", 0],
		["G<sup>&#x266f;</sup>", "G sharp", "G", "&#x266f;", 0],
		["G<sup>&#x266d;</sup>", "G flat",  "G", "&#x266d;", 0],
	]

	song_key.each do |key|
		SongKey.create( key_symbol: key[0], key_full_name: key[1], key_root: key[2], key_modifier: key[3], capo_fret: key[4] )
	end

	roles = ["admin", "player"]
	roles.each do |roll|
		Role.create( name: roll )
	end
