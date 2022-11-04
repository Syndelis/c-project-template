# ------------------------------------------------------------------------------
# Platform specific tweaks
# ------------------------------------------------------------------------------

ifeq ($(OS),Windows_NT)
	MKDIR=powershell -file .\utils\mkdir.ps1 -dirs
	RMRF=powershell -file .\utils\rm.ps1 -dirs
else
	MKDIR=mkdir -p
	RMRF=rm -rf
endif

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

CC=gcc -std=c17
CFLAGS=-g

INCLUDE_DIRS=-I. $(foreach path,$(wildcard ./lib/*), -I$(path)/include/)
LINK_DIRS=
LINKS=
DEFINE=

SRC_DIR=src
SRC=$(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/**/*.c)
OBJ_DIR=obj
OBJ=$(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC))
OBJ_SUB_DIRS=$(sort $(dir $(OBJ)))
EXE=main

VPATH=$(wildcard $(SRC_DIR)/*)

# ------------------------------------------------------------------------------
# Rules
# ------------------------------------------------------------------------------

all: $(EXE)

$(OBJ_DIR):
	$(MKDIR) "$@"
	$(MKDIR) $(OBJ_SUB_DIRS)

$(EXE): $(OBJ_DIR) $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(INCLUDE_DIRS) $(LINK_DIRS) $(LINKS) $(DEFINE)

$(OBJ): $(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INCLUDE_DIRS) $(LINK_DIRS) $(LINKS) $(DEFINE)

full-clean: clean

clean:
	$(RMRF) $(OBJ_DIR) $(EXE)

# ------------------------------------------------------------------------------
# Profiles
# ------------------------------------------------------------------------------

release: CFLAGS=-Wno-unused-result -ffunction-sections -fdata-sections -ffast-math -Wl,--gc-sections -Wl,--print-gc-sections
release: all
