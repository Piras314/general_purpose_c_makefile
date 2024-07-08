# The indentation for this Makefile is made for an indentation size of 4, and may look odd or wonky if you're viewing it with a different size.
# IMPORTANT: IF YOU ARE ADDING TO AN ALREADY EXISTING VARIABLE, YOU MUST USE +=, NOT =, YOU CAN SEE THIS EASILY WITH THE CFLAGS.

UNAME_S = $(shell uname -s)

# The name of the project, most notably used for the name of the executable 
PROJNAME = game

# Choose a compiler and its settings
CC		= clang
CFLAGS	= -std=c99 -O0 -g -Wall -Wextra -Wpedantic -Wstrict-aliasing
CFLAGS	+= -Wno-pointer-arith -Wno-newline-eof -Wno-unused-parameter -Wno-gnu-statement-expression
CFLAGS	+= -Wno-gnu-compound-literal-initializer -Wno-gnu-zero-variadic-macro-arguments
CFLAGS	+= -fbracket-depth=1024

# System libraries go here (e.g. LDFLAGS = -lncurses)
# Submodule libraries go here (e.g. LDFLAGS += lib/glad/src/glad.o)

# If your project is really big, you may need to add more wildcards to SRC, (e.g. src/**/**/**/**/*.c).
SRC		= $(wildcard src/**/*.c) $(wildcard src/*.c) $(wildcard src/**/**/*.c) $(wildcard src/**/**/**/*.c)
OBJ		= $(SRC:.c=.o)

# The name of the folder where binaries will be stored
BIN		= bin

.PHONY: all clean

# Build everything
all: dirs libs $(PROJNAME)

# Ensures $(BIN) directory is created, builds the project, and runs it. All in one command.
quick: dirs $(PROJNAME) run

# This is used for building libraries stored within this project's files 
# Typically this will involve a git submodule in a "lib/" folder
libs:
	echo "No libraries within this project's files."

# Create $(BIN) directory
dirs:
	mkdir -p ./$(BIN)

# Run the executable
run:
	$(BIN)/$(PROJNAME)

# Build the project (not including libraries)
$(PROJNAME): $(OBJ)
	$(CC) -o $(BIN)/$(PROJNAME) $^ $(LDFLAGS)
%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

# Clean the build files 
clean:
	rm -rf $(BIN) $(OBJ)
