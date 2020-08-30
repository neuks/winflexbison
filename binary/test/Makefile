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
PPFLAGS=-Iinclude
ASFLAGS=$(PPFLAGS)
CCFLAGS=$(PPFLAGS) -g
CXFLAGS=$(CCFLAGS)
DBFLAGS=
RCFLAGS=
FLFLAGS=
BSFLAGS=
LDFLAGS=
EXFLAGS=

# Projects
OBJECT1=yacc.o \
				lex.o
OUTPUT1=main.exe

# Summary
LIBRARY=
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
