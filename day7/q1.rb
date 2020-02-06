#/usr/sbin/env ruby

require 'pp'

class Sunny_with_a_Chance_of_Asteroids

	def initialize (program,first_input_instruction,second_input_instruction)
		@program = program
		@first_input_instruction  = first_input_instruction
		@second_input_instruction = second_input_instruction

		@pointer = 0
		@input   = @first_input_instruction
		@output  = ""
	end


	def execute
		while @program[@pointer] != 99 do

			operation_code = @program[@pointer]

			if operation_code > 9
				operation_code   = @program[@pointer].to_s[-2..-1].to_i
				x_parameter_mode = @program[@pointer].to_s[-3].to_i
				y_parameter_mode = @program[@pointer].to_s[-4].to_i

				x_parameter_mode = 0 if @program[@pointer].to_s[-3] == nil
				y_parameter_mode = 0 if @program[@pointer].to_s[-4] == nil
			else
				x_parameter_mode = y_parameter_mode = 0
			end

			x = (x_parameter_mode == 0) ? @program[@program[@pointer+1]] : @program[@pointer+1]
			y = (y_parameter_mode == 0) ? @program[@program[@pointer+2]] : @program[@pointer+2]
			z = @program[@pointer+3]

			self.ope_1(x,y,z) if operation_code == 1
			self.ope_2(x,y,z) if operation_code == 2
			self.ope_3(@program[@pointer+1]) if operation_code == 3
			self.ope_4(@program[@pointer+1]) if operation_code == 4
			self.ope_5(x,y)   if operation_code == 5
			self.ope_6(x,y)   if operation_code == 6
			self.ope_7(x,y,z) if operation_code == 7
			self.ope_8(x,y,z) if operation_code == 8
		end
		return @output
	end

	def ope_1 (x,y,z)
		@program[z] = x + y
		@pointer += 4
	end

	def ope_2 (x,y,z)
		@program[z] = x * y
		@pointer += 4
	end

	def ope_3 (x)
		@program[x] = @input
		@input = @second_input_instruction
		@pointer += 2
	end

	def ope_4 (x)
		@output = @program[x]
		@pointer += 2
	end

	def ope_5(x,y)
		@pointer = (x != 0) ? y : @pointer+3
	end

	def ope_6(x,y)
		@pointer = (x == 0) ? y : @pointer+3
	end

	def ope_7 (x,y,z) 
		@program[z] = (x < y) ? 1 : 0
		@pointer += 4
	end

	def ope_8 (x,y,z) 
		@program[z] = (x == y) ? 1 : 0
		@pointer += 4
	end
end

program = [3,8,1001,8,10,8,105,1,0,0,21,30,55,76,97,114,195,276,357,438,99999,3,9,102,3,9,9,4,9,99,3,9,1002,9,3,9,1001,9,5,9,1002,9,2,9,1001,9,2,9,102,2,9,9,4,9,99,3,9,1002,9,5,9,1001,9,2,9,102,5,9,9,1001,9,4,9,4,9,99,3,9,1001,9,4,9,102,5,9,9,101,4,9,9,1002,9,4,9,4,9,99,3,9,101,2,9,9,102,4,9,9,1001,9,5,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99]
maximum_output = 0
phase_setting_conbination = [0,1,2,3,4].permutation(5).to_a

phase_setting_conbination.each do |phase_setting|
	output = ""
	second_input_instruction = 0
	phase_setting.each do |first_input_instruction|
		output = Sunny_with_a_Chance_of_Asteroids.new(program,first_input_instruction,second_input_instruction).execute
		second_input_instruction = output
	end
	maximum_output = output if maximum_output < output
end

puts maximum_output
