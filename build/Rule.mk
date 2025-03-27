ifndef ROOTDIR
	ROOTDIR := ${CURDIR}
endif

.PHONY: all force

DIRS := $(filter %/, $(obj-y))
FILES := $(filter-out %/, $(obj-y))

%.o : %.c 
	@echo "[CC] $@"
	@$(CC) $(CFLAGS) -c -o $@ $^

%.o : %.cc 
	@echo "[CXX] $@"
	@$(CXX) $(CFLAGS) -c -o $@ $^

%.o : %.cpp 
	@echo "[CXX] $@"
	@$(CXX) $(CFLAGS) -c -o $@ $^

$(output-y) : $(obj-y)
	@echo "[Output] $@"
	@$(CXX) -o $@ $^

%/: force 
	@echo "Build under subfolder $*"
	$(MAKE) -C $* -f Makefile -f $(ROOTDIR)/build/Rule.mk ROOTDIR=$(ROOTDIR)

all: $(obj-y)
	@echo "Test Building $^"
