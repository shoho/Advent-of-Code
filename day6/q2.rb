#/usr/sbin/env ruby

require 'pp'

objects = {}

START = "COM"

File.foreach("q1.txt") do |l|
#File.foreach("sample2.txt") do |l|
	parent,child = l.split(")")
	objects[child.strip!] = parent
end

def getOrbits (hash, val, c = 1, orbits=[])
	parent = hash[val]

	orbits << parent
	return orbits if parent == START

	getOrbits(hash, parent, c+1, orbits)
end

def getIntersection (you_path, san_path)
	return (you_path & san_path).first
end

you_path = getOrbits(objects, "YOU")
san_path = getOrbits(objects, "SAN")

intersection = getIntersection(you_path, san_path)

puts you_path.index(intersection).to_i + san_path.index(intersection).to_i
