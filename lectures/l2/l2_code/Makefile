top: counter.v register.v control.v top.v top_tb.v
	iverilog -o top  counter.v register.v control.v top.v top_tb.v
	./top

clean: 
	rm -f top *~ *.vcd

.PHONY: clean all
