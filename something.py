print("Hello Esha")
import csv
with open("C:\Users\esha2\Desktop\esha_machine.txt","r") as code_file:
	code_file_reader=csv.reader(code_file)
	code_list=[]
	code_list=list(code_file_reader)
code_file.close()
size=int(len(code_list))
instr_list=[]
machine_code=[]
for i in range (size):
	opcode = code_list[i][0]
	print(opcode)
	if (opcode == "hlt"):
		machine_code=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	elif (opcode == "jmp"):
		operand_2=code_list[i][1]
		operand_2_int=int(operand_2,16)
		op_2="{0:026b}".format(operand_2_int)
		machine_code[0:6]=[0,0,1,1,0,0]
		machine_code[6:]=list(op_2)
	else:
		operand_1 = int(code_list[i][1])
		op_1="{0:05b}".format(operand_1)
		operand_2 = int(code_list[i][2])
		op_2="{0:05b}".format(operand_2)
		if (opcode == "add"):
			machine_code[0:6]=[0,0,0,0,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = int(code_list[i][3])
			op_3="{0:05b}".format(operand_3)
			machine_code[16:21]=list(op_3)
			machine_code[26:]=[0,1,0,0,0,0]
		if (opcode == "sub"):
			machine_code[0:6]=[0,0,0,0,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = int(code_list[i][3])
			op_3="{0:05b}".format(operand_3)
			machine_code[16:21]=list(op_3)
			machine_code[26:]=[0,1,0,0,0,1]	
		if (opcode == "and"):
			machine_code[0:6]=[0,0,0,0,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = int(code_list[i][3])
			op_3="{0:05b}".format(operand_3)
			machine_code[16:21]=list(op_3)
			machine_code[26:]=[0,1,0,0,1,0]	
		if (opcode == "or"):
			machine_code[0:6]=[0,0,0,0,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = int(code_list[i][3])
			op_3="{0:05b}".format(operand_3)
			machine_code[16:21]=list(op_3)
			machine_code[26:]=[0,1,0,0,1,1]	
		if (opcode == "nor"):
			machine_code[0:6]=[0,0,0,0,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = int(code_list[i][3])	
			op_3="{0:05b}".format(operand_3)
			machine_code[16:21]=list(op_3)
			machine_code[26:]=[0,1,0,1,0,0]	
		if (opcode == "addi"):
			machine_code[0:6]=[0,0,0,0,0,1]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "subi"):
			machine_code[0:6]=[0,0,0,0,1,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)			
		if (opcode == "andi"):
			machine_code[0:6]=[0,0,0,0,1,1]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)			
		if (opcode == "ori"):
			machine_code[0:6]=[0,0,0,1,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)			
		if (opcode == "shl"):
			machine_code[0:6]=[0,0,0,1,0,1]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "shr"):
			machine_code[0:6]=[0,0,0,1,1,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "lw"):
			machine_code[0:6]=[0,0,0,1,1,1]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "sw"):
			machine_code[0:6]=[0,0,1,0,0,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "blt"):
			machine_code[0:6]=[0,0,1,0,0,1]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "beq"):
			machine_code[0:6]=[0,0,1,0,1,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "beq"):
			machine_code[0:6]=[0,0,1,0,1,0]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
		if (opcode == "bne"):
			machine_code[0:6]=[0,0,1,0,1,1]
			machine_code[6:11]=list(op_1)
			machine_code[11:16]=list(op_2)
			operand_3 = code_list[i][3]
			operand_3_int=int(operand_3,16)
			op_3="{0:016b}".format(operand_3_int)
			machine_code[16:]=list(op_3)
			#write other instructions here
	mach_code=''.join(str(j) for j in machine_code)
	instr_int=(int(mach_code,2))
	instr=format(instr_int,'X')
	instruc=str(instr)
	instruct=instruc.zfill(8)
	filler='X"'
	instruction=filler+instruct
	print(instruction)
	instr_list.append(instruction)
with open("C:\Users\esha2\Desktop\hex_code.txt","w") as instr_file:
	instr_file_writer=csv.writer(instr_file)
	instr_file_writer.writerow(instr_list)
instr_file.close()
print(instr_list)