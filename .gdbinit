set disassembly-flavor intel
set disassemble-next-line on

set history filename ~/var/log/gdb-history
set history save on
set print pretty on
set pagination off
set confirm off

set index-cache enabled

define xxd
dump binary memory dump.bin $arg0 $arg0+$arg1
shell xxd dump.bin
end
