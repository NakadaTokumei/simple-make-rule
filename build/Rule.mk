.PHONY: force all

DIRS := $(filter %/, $(obj-y))
FILES := $(filter-out %/, $(obj-y))

CC=gcc
CXX=g++

%.o : %.c 
	@echo "[CC] $@"
	@$(CC) -c -o $@ $^

%.o : %.cc 
	@echo "[CXX] $@"
	@$(CXX) -c -o $@ $^

$(output-y) : $(obj-y)
	@echo "[Output] $@"
	@$(CXX) -o $@ $^

%/: force
	@echo "Build under subfolder $*"
	@$(MAKE) -C $* -f Makefile -f $(abspath build/Rule.mk)

all: $(obj-y)
	@echo "Test Building $^"

