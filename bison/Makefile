############################################################################### 
# General Purpose Microsoft Makefile
# 
# Copyright (C) 2018, Martin Tang
############################################################################### 

# Toolchain
AR=$(TARGET)ar
PP=$(TARGET)cpp
AS=$(TARGET)as
CC=$(TARGET)gcc
CX=$(TARGET)g++
DB=$(TARGET)gdb
OD=$(TARGET)objdump
OC=$(TARGET)objcopy
RC=windres
FL=flex
BS=bison
LD=$(TARGET)gcc
RM=rm

# Configuration
ARFLAGS=cr
PPFLAGS=-I. -Isrc -I../common/m4 -I../common/m4/lib -I../common/misc \
				-Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -D_CONSOLE
ASFLAGS=$(PPFLAGS)
CCFLAGS=$(PPFLAGS) -O3
CXFLAGS=$(PPFLAGS) -O3
DBFLAGS=
RCFLAGS=
FLFLAGS=
BSFLAGS=
LDFLAGS=-L../common
EXFLAGS=

# Projects
OBJECT1=src/AnnotationList.o \
				src/assoc.o \
				src/closure.o \
				src/complain.o \
				src/conflicts.o \
				src/counterexample.o \
				src/derivation.o \
				src/derives.o \
				src/files.o \
				src/fixits.o \
				src/getargs.o \
				src/glyphs.o \
				src/gram.o \
				src/graphviz.o \
				src/ielr.o \
				src/InadequacyList.o \
				src/lalr.o \
				src/location.o \
				src/LR0.o \
				src/lssi.o \
				src/main.o \
				src/muscle-tab.o \
				src/named-ref.o \
				src/nullable.o \
				src/output.o \
				src/parse-gram.o \
				src/parse-simulation.o \
				src/print.o \
				src/print-graph.o \
				src/print-xml.o \
				src/reader.o \
				src/reduce.o \
				src/relation.o \
				src/Sbitset.o \
				src/scan-code-c.o \
				src/scan-gram-c.o \
				src/scan-skel-c.o \
				src/state.o \
				src/state-item.o \
				src/symlist.o \
				src/symtab.o \
				src/tables.o \
				src/uniqstr.o
OUTPUT1=bison.exe

# Summary
LIBRARY=-lcommon -lkernel32 -luser32
OBJECTS=$(OBJECT1)
OUTPUTS=$(OUTPUT1)
DEPENDS=$(OBJECTS:.o=.dep)
COMCMDS=$(OBJECTS:.o=.coc)
CLEANUP=$(DEPENDS) $(OBJECTS) $(OUTPUTS)

# Build Commands
all: $(OUTPUTS)
coc: compile_commands.json

$(OUTPUT1) : $(OBJECT1)

run: $(OUTPUTS)
	@echo [EX] $<
	@$< $(EXFLAGS)

debug: $(OUTPUTS)
	@echo [DB] $<
	@$(DB) $(DBFLAGS) $<

clean:
	@echo [RM] $(CLEANUP)
	-@$(RM) $(CLEANUP)

compile_commands.json: $(COMCMDS)
	@echo "[" > $@.tmp
	@cat $^ >> $@.tmp
	@sed '$$d' < $@.tmp > $@
	@echo "  }" >> $@
	@echo "]" >> $@
	@rm $(COMCMDS) $@.tmp

# Standard Procedures
%.coc : %.c
	@echo "  {" > $@
	@echo "    \"command\": \"$(CC) $(CCFLAGS) -c -o $@ $<\","    >> $@
	@echo "    \"directory\": \"$(CURDIR)\","                     >> $@
	@echo "    \"file\": \"$<\""                                  >> $@
	@echo "  },"                                                  >> $@

%.coc : %.cpp
	@echo "  {" > $@
	@echo "    \"command\": \"@$(CX) $(CXFLAGS) -c -o $@ $<\","   >> $@
	@echo "    \"directory\": \"$(CURDIR)\","                     >> $@
	@echo "    \"file\": \"$<\""                                  >> $@
	@echo "  },"                                                  >> $@

%.coc : %.rc

%.dep : %.S
	@$(PP) $(PPFLAGS) -MM -MT $(@:.dep=.o) -o $@ $< 2> /dev/null

%.dep : %.c
	@$(PP) $(PPFLAGS) -MM -MT $(@:.dep=.o) -o $@ $< 2> /dev/null

%.dep : %.cpp
	@$(PP) $(PPFLAGS) -MM -MT $(@:.dep=.o) -o $@ $< 2> /dev/null

%.dep : %.rc
	@$(PP) $(PPFLAGS) -MM -MT $(@:.dep=.o) -o $@ $< 2> /dev/null

%.dep : %.l
	@$(PP) $(PPFLAGS) -MM -MT $(@:.dep=.o) -o $@ $< 2> /dev/null

%.dep : %.y
	@$(PP) $(PPFLAGS) -MM -MT $(@:.dep=.o) -o $@ $< 2> /dev/null

%.o : %.S
	@echo [AS] $<
	@$(AS) $(ASFLAGS) -c -o $@ $<

%.o : %.c
	@echo [CC] $<
	@$(CC) $(CCFLAGS) -c -o $@ $<

%.o : %.cpp
	@echo [CX] $<
	@$(CX) $(CXFLAGS) -c -o $@ $<

%.o : %.rc
	@echo [RC] $<
	@$(RC) $(RCFLAGS) -o $@ $<

%.c : %.l
	@echo [FL] $<
	@$(FL) $(FLFLAGS) -o $@ $<

%.c : %.y
	@echo [BS] $<
	@$(BS) $(BSFLAGS) -d -o $@ $<

%.a :
	@echo [AR] $@
	@$(AR) $(ARFLAGS) $@ $^

%.dll :
	@echo [LD] $@
	@$(LD) $(LDFLAGS) -o $@ $^ $(LIBRARY)

%.exe :
	@echo [LD] $@
	@$(LD) $(LDFLAGS) -o $@ $^ $(LIBRARY)

%.elf:
	@echo [LD] $@
	@$(LD) $(LDFLAGS) -o $@ $^ $(LIBRARY)

%.hex : %.exe
	@echo [OC] $@
	@$(OC) -O ihex $< $@

%.hex : %.elf
	@echo [OC] $@
	@$(OC) -O ihex $< $@

ifneq ($(MAKECMDGOALS),clean)
-include $(DEPENDS)
endif
