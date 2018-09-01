
#executable file name
EXE = main
CURRENT_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))

# C++ compile flags
CXXFLAGS += -std=c++11
# header search cflags
INCLUDEFLAGS += 
CXXFLAGS += $(INCLUDEFLAGS)

# build objects output path
BUILD_PATH = build

# exclude path
EXCLUDE_PATH += $(BUILD_PATH)

SRC_PATH := $(shell find . -type d)
SRC_PATH := $(patsubst ./%, %, $(SRC_PATH))
SRC_PATH := $(filter-out $(EXCLUDE_PATH)/%, $(SRC_PATH))
SRC_PATH := $(filter-out $(EXCLUDE_PATH), $(SRC_PATH))

CXX_SRC = $(foreach n, $(SRC_PATH), $(wildcard $(n)/*.cpp))

SRC := $(patsubst ./%, %, $(CXX_SRC))
OBJ := $(addprefix $(BUILD_PATH)/, $(SRC))
OBJ := ${OBJ:.cpp=.o}

$(foreach n, $(SRC_PATH), $(shell mkdir -p "$(BUILD_PATH)/$(n)"))

DEP += $(patsubst %.o, %.d, $(OBJ))

# assign default target
# .DEFAULT_GOAL := all

all:$(EXE)

# use '-' ignore warning
-include $(DEP)

$(EXE):$(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@

$(BUILD_PATH)/%.d : %.cpp
	set -e; rm -f $@; $(CC) -MM $< $(INCLUDEFLAGS) > $@.$$$$; \
	sed 's,\(^[^\s]*\)\.o\s*[:],$(BUILD_PATH)/$*.o $@: ,' $@.$$$$ > $@; \
	rm -f $@.$$$$

$(BUILD_PATH)/%.o: %.cpp
	$(CXX) -c $< -o $@


# clean build objects
.PHONY: clean
clean:
	rm -fr $(BUILD_PATH)
	rm -fr $(EXE)

# debug target

.PHONY: current_path
current_path:
	echo $(CURRENT_PATH)

.PHONY: clean
src_path:
	echo $(SRC_PATH)

.PHONY: exclude_dirs
exclude_dirs:
	echo $(EXCLUDE_DIRS)

.PHONY: cxx_src
cxx_src:
	echo $(CXX_SRC)

.PHONY: obj
obj:
	echo $(OBJ)

.PHONY: dep
dep:
	echo $(DEP)

.PHONY: wld
wld:
	echo $(wildcard ./*.cpp)
