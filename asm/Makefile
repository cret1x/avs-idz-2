LIBS = lib/io.o lib/str.o lib/array.o lib/time.o lib/rand.o
.PHONY: default compile build run debug
default: build run
compile: lib/io.s
	as lib/io.s -o lib/io.o
	as lib/str.s -o lib/str.o
	as lib/array.s -o lib/array.o
	as lib/time.s -o lib/time.o
	as lib/rand.s -o lib/rand.o
build: main.s
	as main.s -o main.o
	ld main.o $(LIBS) -o main
run: main
	./main $(ARGS)
debug: main.s
	as --gstabs -o main.o main.s
	ld main.o $(LIBS) -o main
	gdb main
