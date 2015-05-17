# makefile test

CXX = g++
CXXFLAGS += -Wall -g -std=c++11
targets = main.exe
sources = main.cpp knightproblem.cpp problem.cpp stairproblem.cpp
objects = $(sources:.cpp=.o)

all: $(targets)

main.exe: $(objects)
	$(CXX) $(CXXFLAGS) -o $@ $(objects)

$(sources:.cpp=.d): %.d: %.cpp
	@rm -f $@
	@$(CXX) -MM $(CXXFLAGS) $< > $@.temp
	@sed "s/\($*\)\.o[ :]*/\1.o $@ :/g" < $@.temp > $@
	@rm -f $@.temp

sinclude $(sources:.cpp=.d)

.PHONY: all clean
clean:
	-rm $(targets) $(objects) $(sources:.cpp=.d)
