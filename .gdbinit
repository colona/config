set history save
set disassembly-flavor intel
set follow-fork-mode child
set disable-randomization on
set print pretty
set confirm off


# From https://github.com/gdbinit/Gdbinit/blob/master/gdbinit

set $ARM = 0

# These make gdb never pause in its output
set height 0
set width 0

# _______________eflags commands______________
# conditional flags are
# negative/less than (N), bit 31 of CPSR
# zero (Z), bit 30
# Carry/Borrow/Extend (C), bit 29
# Overflow (V), bit 28

# negative/less than (N), bit 31 of CPSR
define cfn
	if $ARM == 1
		set $tempflag = $cpsr->n
		if ($tempflag & 1)
			set $cpsr->n = $tempflag&~0x1
		else
			set $cpsr->n = $tempflag|0x1
		end
	end
end
document cfn
Change Negative/Less Than Flag.
end


define cfc
# Carry/Borrow/Extend (C), bit 29
	if $ARM == 1
		set $tempflag = $cpsr->c
		if ($tempflag & 1)
			set $cpsr->c = $tempflag&~0x1
		else
			set $cpsr->c = $tempflag|0x1
		end
	else
		if ($eflags & 1)
			set $eflags = $eflags&~0x1
		else
			set $eflags = $eflags|0x1
		end
	end
end
document cfc
Change Carry Flag.
end


define cfp
	if (($eflags >> 2) & 1)
		set $eflags = $eflags&~0x4
	else
		set $eflags = $eflags|0x4
	end
end
document cfp
Change Parity Flag.
end


define cfa
	if (($eflags >> 4) & 1)
		set $eflags = $eflags&~0x10
	else
		set $eflags = $eflags|0x10
	end
end
document cfa
Change Auxiliary Carry Flag.
end


define cfz
# zero (Z), bit 30
	if $ARM == 1
		set $tempflag = $cpsr->z
		if ($tempflag & 1)
			set $cpsr->z = $tempflag&~0x1
		else
			set $cpsr->z = $tempflag|0x1
		end
	else
		if (($eflags >> 6) & 1)
			set $eflags = $eflags&~0x40
		else
			set $eflags = $eflags|0x40
		end
	end
end
document cfz
Change Zero Flag.
end


define cfs
	if (($eflags >> 7) & 1)
		set $eflags = $eflags&~0x80
	else
		set $eflags = $eflags|0x80
	end
end
document cfs
Change Sign Flag.
end


define cft
	if (($eflags >>8) & 1)
		set $eflags = $eflags&~0x100
	else
		set $eflags = $eflags|0x100
	end
end
document cft
Change Trap Flag.
end


define cfi
	if (($eflags >> 9) & 1)
		set $eflags = $eflags&~0x200
	else
		set $eflags = $eflags|0x200
	end
end
document cfi
Change Interrupt Flag.
Only privileged applications (usually the OS kernel) may modify IF.
This only applies to protected mode (real mode code may always modify IF).
end


define cfd
	if (($eflags >>0xA) & 1)
		set $eflags = $eflags&~0x400
	else
		set $eflags = $eflags|0x400
	end
end
document cfd
Change Direction Flag.
end


define cfo
	if (($eflags >> 0xB) & 1)
		set $eflags = $eflags&~0x800
	else
		set $eflags = $eflags|0x800
	end
end
document cfo
Change Overflow Flag.
end


# Overflow (V), bit 28
define cfv
	if $ARM == 1
		set $tempflag = $cpsr->v
		if ($tempflag & 1)
			set $cpsr->v = $tempflag&~0x1
		else
			set $cpsr->v = $tempflag|0x1
		end
	end
end
document cfv
Change Overflow Flag.
end


# ____________________patch___________________
# the usual nops are mov r0,r0 for arm (0xe1a00000)
# and mov r8,r8 in Thumb (0x46c0)
# armv7 has other nops
# FIXME: make sure that the interval fits the 32bits address for arm and 16bits for thumb
# status: works, fixme
define nop
	if ($argc > 2 || $argc == 0)
		help nop
	end

	if $ARM == 1
		if ($argc == 1)
			if ($cpsr->t &1)
				# thumb
				set *(short *)$arg0 = 0x46c0
			else
				# arm
				set *(int *)$arg0 = 0xe1a00000
			end
		else
			set $addr = $arg0
			if ($cpsr->t & 1)
				# thumb
				while ($addr < $arg1)
					set *(short *)$addr = 0x46c0
					set $addr = $addr + 2
				end
			else
				# arm
				while ($addr < $arg1)
					set *(int *)$addr = 0xe1a00000
					set $addr = $addr + 4
				end
			end
		end
	else
		if ($argc == 1)
			set *(unsigned char *)$arg0 = 0x90
		else
			set $addr = $arg0
			while ($addr < $arg1)
				set *(unsigned char *)$addr = 0x90
				set $addr = $addr + 1
			end
		end
	end
end
document nop
Usage: nop ADDR1 [ADDR2]
Patch a single byte at address ADDR1, or a series of bytes between ADDR1 and ADDR2 to a NOP (0x90) instruction.
ARM or Thumb code will be patched accordingly.
end


define null
	if ( $argc >2 || $argc == 0)
		help null
	end

	if ($argc == 1)
		set *(unsigned char *)$arg0 = 0
	else
		set $addr = $arg0
		while ($addr < $arg1)
			set *(unsigned char *)$addr = 0
			set $addr = $addr +1
		end
	end
end
document null
Usage: null ADDR1 [ADDR2]
Patch a single byte at address ADDR1 to NULL (0x00), or a series of bytes between ADDR1 and ADDR2.
end

# FIXME: thumb breakpoint ?
define int3
	if $argc != 1
		help int3
	else
		if $ARM == 1
			set $ORIGINAL_INT3 = *(unsigned int *)$arg0
			set $ORIGINAL_INT3ADDRESS = $arg0
			set *(unsigned int*)$arg0 = 0xe7ffdefe
		else
			# save original bytes and address
			set $ORIGINAL_INT3 = *(unsigned char *)$arg0
			set $ORIGINAL_INT3ADDRESS = $arg0
			# patch
			set *(unsigned char *)$arg0 = 0xCC
		end
	end
end
document int3
Patch byte at address ADDR to an INT3 (0xCC) instruction or the equivalent software breakpoint for ARM.
Usage: int3 ADDR
end


define rint3
	if $ARM == 1
		set *(unsigned int *)$ORIGINAL_INT3ADDRESS = $ORIGINAL_INT3
		set $pc = $ORIGINAL_INT3ADDRESS
	else
		set *(unsigned char *)$ORIGINAL_INT3ADDRESS = $ORIGINAL_INT3
		if sizeof(void *) == 8
			set $rip = $ORIGINAL_INT3ADDRESS
		else
			set $eip = $ORIGINAL_INT3ADDRESS
		end
	end
end
document rint3
Restore the original byte previous to int3 patch issued with "int3" command.
end


# ____________________cflow___________________
define print_insn_type
	if $argc != 1
		help print_insn_type
	else
		if ($arg0 < 0 || $arg0 > 5)
			printf "UNDEFINED/WRONG VALUE"
		end
		if ($arg0 == 0)
			printf "UNKNOWN"
		end
		if ($arg0 == 1)
			printf "JMP"
		end
		if ($arg0 == 2)
			printf "JCC"
		end
		if ($arg0 == 3)
			printf "CALL"
		end
		if ($arg0 == 4)
			printf "RET"
		end
		if ($arg0 == 5)
			printf "INT"
		end
	end
end
document print_insn_type
Print human-readable mnemonic for the instruction type (usually $INSN_TYPE).
Usage: print_insn_type INSN_TYPE_NUMBER
end


define get_insn_type
	if $argc != 1
		help get_insn_type
	else
		set $INSN_TYPE = 0
		set $_byte1 = *(unsigned char *)$arg0
		if ($_byte1 == 0x9A || $_byte1 == 0xE8)
			# "call"
			set $INSN_TYPE = 3
		end
		if ($_byte1 >= 0xE9 && $_byte1 <= 0xEB)
			# "jmp"
			set $INSN_TYPE = 1
		end
		if ($_byte1 >= 0x70 && $_byte1 <= 0x7F)
			# "jcc"
			set $INSN_TYPE = 2
		end
		if ($_byte1 >= 0xE0 && $_byte1 <= 0xE3 )
			# "jcc"
			set $INSN_TYPE = 2
		end
		if ($_byte1 == 0xC2 || $_byte1 == 0xC3 || $_byte1 == 0xCA || \
			$_byte1 == 0xCB || $_byte1 == 0xCF)
			# "ret"
			set $INSN_TYPE = 4
		end
		if ($_byte1 >= 0xCC && $_byte1 <= 0xCE)
			# "int"
			set $INSN_TYPE = 5
		end
		if ($_byte1 == 0x0F )
			# two-byte opcode
			set $_byte2 = *(unsigned char *)($arg0 + 1)
			if ($_byte2 >= 0x80 && $_byte2 <= 0x8F)
				# "jcc"
				set $INSN_TYPE = 2
			end
		end
		if ($_byte1 == 0xFF)
			# opcode extension
			set $_byte2 = *(unsigned char *)($arg0 + 1)
			set $_opext = ($_byte2 & 0x38)
			if ($_opext == 0x10 || $_opext == 0x18)
				# "call"
				set $INSN_TYPE = 3
			end
			if ($_opext == 0x20 || $_opext == 0x28)
				# "jmp"
				set $INSN_TYPE = 1
			end
		end
	end
end
document get_insn_type
Recognize instruction type at address ADDR.
Take address ADDR and set the global $INSN_TYPE variable to
0, 1, 2, 3, 4, 5 if the instruction at that address is
unknown, a jump, a conditional jump, a call, a return, or an interrupt.
Usage: get_insn_type ADDR
end


define step_to_call

	set logging file /dev/null
	set logging redirect on
	set logging on

	set $_cont = 1
	while ($_cont > 0)
		stepi
		get_insn_type $pc
		if ($INSN_TYPE == 3)
			set $_cont = 0
		end
	end

	set logging off

	set logging file /tmp/gdb.txt
	set logging redirect off
	set logging on

	printf "step_to_call command stopped at:\n  "
	x/i $pc
	printf "\n"
	set logging off

end
document step_to_call
Single step until a call instruction is found.
Stop before the call is taken.
Log is written into the file /tmp/gdb.txt.
end


define trace_calls

	printf "Tracing...please wait...\n"

	set $_nest = 1
	set listsize 0

	set logging overwrite on
	set logging file /tmp/gdb_trace_calls.txt
	set logging on
	set logging off

	printf "\n"
	set logging overwrite off

	while ($_nest > 0)
		get_insn_type $pc
		# handle nesting
		if ($INSN_TYPE == 3)
			set $_nest = $_nest + 1
		else
			if ($INSN_TYPE == 4)
				set $_nest = $_nest - 1
			end
		end
		# if a call, print it
		if ($INSN_TYPE == 3)
			set logging file /tmp/gdb_trace_calls.txt
			set logging redirect off
			set logging on

			set $x = $_nest - 2
			while ($x > 0)
				printf "\t"
				set $x = $x - 1
			end
			x/i $pc
		end

		set logging off
		set logging file /dev/null
		set logging redirect on
		set logging on
		stepi
		set logging redirect off
		set logging off
	end

	printf "Done, check /tmp/gdb_trace_calls.txt\n"
end
document trace_calls
Create a runtime trace of the calls made by target.
Log overwrites(!) the file /tmp/gdb_trace_calls.txt.
end


define trace_run
	printf "Tracing...please wait...\n"

	set logging overwrite on
	set logging file /tmp/gdb_trace_run.txt
	set logging redirect on
	set logging on
	set $_nest = 1

	printf "\n"
	set logging overwrite off

	while ( $_nest > 0 )

		get_insn_type $pc
		# jmp, jcc, or cll
		if ($INSN_TYPE == 3)
			set $_nest = $_nest + 1
		else
			# ret
			if ($INSN_TYPE == 4)
				set $_nest = $_nest - 1
			end
		end
		stepi
	end

	printf "\n"

	set logging redirect off
	set logging off

	# clean up trace file
	shell  grep -v ' at ' /tmp/gdb_trace_run.txt > /tmp/gdb_trace_run.1
	shell  grep -v ' in ' /tmp/gdb_trace_run.1 > /tmp/gdb_trace_run.txt
	shell  rm -f /tmp/gdb_trace_run.1
	printf "Done, check /tmp/gdb_trace_run.txt\n"
end
document trace_run
Create a runtime trace of target.
Log overwrites(!) the file /tmp/gdb_trace_run.txt.
end

# original by Tavis Ormandy (http://my.opera.com/taviso/blog/index.dml/tag/gdb) (great fix!)
# modified to work with Mac OS X by fG!
# seems nasm shipping with Mac OS X has problems accepting input from stdin or heredoc
# input is read into a variable and sent to a temporary file which nasm can read
define assemble
	# dont enter routine again if user hits enter
	dont-repeat
	if ($argc)
		if (*$arg0 = *$arg0)
		# check if we have a valid address by dereferencing it,
		# if we havnt, this will cause the routine to exit.
		end

		# argument, assemble instructions into memory at the given address
		if (sizeof(void *) == 8)
			shell ASMOPCODE="$(while read r && test "$r" != end ; do echo -E "$r"; done)"; \
				echo -e "BITS 64\n$ASMOPCODE" >/tmp/.assembly; \
				/usr/bin/nasm -f bin -o /dev/stdout /tmp/.assembly \
					| /usr/bin/hexdump -ve '1/1 "set *((unsigned char *) $arg0 + %#2_ax) = %#02x\n"' \
					>/tmp/.gdbassemble ;
		else
			shell ASMOPCODE="$(while read r && test "$r" != end ; do echo -E "$r"; done)"; \
				echo -e "BITS 32\n$ASMOPCODE" >/tmp/.assembly; \
				/usr/bin/nasm -f bin -o /dev/stdout /tmp/.assembly \
					| /usr/bin/hexdump -ve '1/1 "set *((unsigned char *) $arg0 + %#2_ax) = %#02x\n"' \
					>/tmp/.gdbassemble;
		end
		source /tmp/.gdbassemble
		# all done. clean the temporary files
		shell /bin/rm -f /tmp/.gdbassemble /tmp/.assembly
	else
		# no argument, assemble instructions to stdout
		if (sizeof(void *) == 8)
			shell ASMOPCODE="$(while read r && test "$r" != end ; do echo -E "$r"; done)"; \
				echo -e "BITS 64\n$ASMOPCODE" >/tmp/.assembly; \
				/usr/bin/nasm -f bin -o /dev/stdout /tmp/.assembly \
					| /usr/bin/ndisasm -i -b64 /dev/stdin
		else
			shell ASMOPCODE="$(while read r && test "$r" != end ; do echo -E "$r"; done)"; \
				echo -e "BITS 32\n$ASMOPCODE" >/tmp/.assembly; \
				/usr/bin/nasm -f bin -o /dev/stdout /tmp/.assembly \
					| /usr/bin/ndisasm -i -b32 /dev/stdin;
		end
		shell /bin/rm -f /tmp/.assembly
	end
end
document assemble
Assemble instructions using nasm.
Type a line containing "end" to indicate the end.
If an address is specified, insert/modify instructions at that address.
If no address is specified, assembled instructions are printed to stdout.
Use the pseudo instruction "org ADDR" to set the base address.
end

define assemble_gas
	dont-repeat
	shell cat > /tmp/.assembly; echo ""; \
		as -o /tmp/.gdbassemble < /tmp/.assembly; \
		objdump -d -j .text /tmp/.gdbassemble; \
		rm -f /tmp/.assembly /tmp/.gdbassemble
end
document assemble_gas
Assemble instructions to binary opcodes. Uses GNU as and objdump.
Usage: assemble_gas
end
