#/usr/sbin/env ruby

require 'pp'

objects = {}

File.foreach("q1.txt") do |l|
	parent,child = l.split(")")
	objects[child.strip!] = parent
end

def countOrbits (hash, val, c = 1)
	parent = hash[val]
	return c if parent == "COM" 

	countOrbits(hash, parent, c+1)
end

output   = 0
children = objects.keys #All objects but "COM"

children.each do |obj|
	output += countOrbits(objects,obj)
end

puts output
