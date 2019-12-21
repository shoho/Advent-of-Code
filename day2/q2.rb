#/usr/sbin/env ruby

require 'pp'

original_arr = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,9,1,19,1,19,6,23,2,6,23,27,2,27,9,31,1,5,31,35,1,35,10,39,2,39,9,43,1,5,43,47,2,47,10,51,1,51,6,55,1,5,55,59,2,6,59,63,2,63,6,67,1,5,67,71,1,71,9,75,2,75,10,79,1,79,5,83,1,10,83,87,1,5,87,91,2,13,91,95,1,95,10,99,2,99,13,103,1,103,5,107,1,107,13,111,2,111,9,115,1,6,115,119,2,119,6,123,1,123,6,127,1,127,9,131,1,6,131,135,1,135,2,139,1,139,10,0,99,2,0,14,0]

#arr = [1,9,10,3,2,3,11,0,99,30,40,50]
#arr = [1,1,1,4,99,5,6,0,99]
#arr = [2,4,4,5,99,0]
#arr = [2,3,0,3,99]
#arr = [1,0,0,0,99]


def replaceNumber(arr,a,b,c,d)
	if a == 1
		arr[d] = arr[b] + arr[c]
	else a == 2
		arr[d] = arr[b] * arr[c]
	end
	arr
end

def execute(arr,x,y)
	i = 0
	arr[1] = x
	arr[2] = y
	while arr[i] != 99 do
		arr = replaceNumber(arr,arr[i], arr[i+1], arr[i+2], arr[i+3])
		i = i+4
	end
	return arr[0]
end

x = y = 1
while x < 100
	while y < 100
		if 19690720 == execute(original_arr.clone,x,y)
			puts "x: " + x.to_s + " y: " + y.to_s
			abort 
		end
		y += 1
	end
	y = 1
	x += 1
end
