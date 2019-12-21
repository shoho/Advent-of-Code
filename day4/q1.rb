#/usr/sbin/env ruby

Start_number = 125730
Last_number = 579381

num = Start_number

class Secure_container

	def initialize (num)
		@num_i = num
		@num_a = num.to_s.chars.map(&:to_i)
		(@d1,@d2,@d3,@d4,@d5,@d6) = @num_a
	end

	def execute
		return false if self.rule1 == false
		return false if self.rule2 == false
		return false if self.rule3 == false
		return false if self.rule4 == false
		return true
	end

	# It is a six-digit number
	def rule1
		100000 <= @num_i and @num_i < 1000000
	end

	# The value is within the range given in your puzzle input.
	def rule2
		Start_number <= @num_i and @num_i < Last_number + 1
	end

	# Two adjacent digits are the same (like 22 in 122345).
	def rule3
		@num_a.uniq.count != 6
	end
	
	# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
	def rule4
		@d6>=@d5 and @d5>=@d4 and @d4>=@d3 and @d3>=@d2 and @d2>=@d1
	end
end


count = 0
while num <= Last_number
	secure_container = Secure_container.new(num)
	if secure_container.execute == true
		count += 1
		# puts num.to_s
	end
	num += 1
end

puts "Count: " + count.to_s
