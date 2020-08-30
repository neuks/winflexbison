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
PPFLAGS=-I. -Im4 -Im4/lib -Imisc -D_LIB \
				-Wno-int-to-pointer-cast -Wno-pointer-to-int-cast
ASFLAGS=$(PPFLAGS)
CCFLAGS=$(PPFLAGS) -O3
CXFLAGS=$(PPFLAGS) -O3
DBFLAGS=
RCFLAGS=
FLFLAGS=
BSFLAGS=
LDFLAGS=
EXFLAGS=

# Projects
OBJECT1=m4/builtin.o \
				m4/debug.o \
				m4/eval.o \
				m4/format.o \
				m4/freeze.o \
				m4/input.o \
				m4/m4.o \
				m4/macro.o \
				m4/output.o \
				m4/path.o \
				m4/symtab.o \
				m4/lib/clean-temp.o \
				m4/lib/cloexec.o \
				m4/lib/close-stream.o \
				m4/lib/closein.o \
				m4/lib/closeout.o \
				m4/lib/execute.o \
				m4/lib/fd-safer.o \
				m4/lib/filenamecat-lgpl.o \
				m4/lib/gl_array_list.o \
				m4/lib/gl_linked_list.o \
				m4/lib/gl_linkedhash_list.o \
				m4/lib/gl_list.o \
				m4/lib/gl_oset.o \
				m4/lib/gl_rbtree_oset.o \
				m4/lib/gl_rbtreehash_list.o \
				m4/lib/gl_xlist.o \
				m4/lib/gl_xoset.o \
				m4/lib/memchr2.o \
				m4/lib/mkdtemp.o \
				m4/lib/mkstemp-safer.o \
				m4/lib/mkstemp.o \
				m4/lib/printf-args.o \
				m4/lib/printf-parse.o \
				m4/lib/regex.o \
				m4/lib/regex_internal.o \
				m4/lib/tempname.o \
				m4/lib/tmpdir.o \
				m4/lib/unicodeio.o \
				m4/lib/vasnprintf.o \
				m4/lib/vasprintf.o \
				m4/lib/verror.o \
				m4/lib/xasprintf.o \
				m4/lib/xprintf.o \
				m4/lib/xvasprintf.o \
				misc/app_path.o \
				misc/argmatch.o \
				misc/basename-lgpl.o \
				misc/bitset.o \
				misc/bitsetv.o \
				misc/c-ctype.o \
				misc/c-strcasecmp.o \
				misc/c-strncasecmp.o \
				misc/concat-filename.o \
				misc/dirname-lgpl.o \
				misc/dirname.o \
				misc/error.o \
				misc/exitfail.o \
				misc/fstrcmp.o \
				misc/get-errno.o \
				misc/gethrxtime.o \
				misc/getdelim.o \
				misc/getline.o \
				misc/getopt.o \
				misc/getopt1.o \
				misc/hash.o \
				misc/localcharset.o \
				misc/mbchar.o \
				misc/mbfile.o \
				misc/mbswidth.o \
				misc/obstack.o \
				misc/obstack_printf.o \
				misc/path-join.o \
				misc/progname.o \
				misc/quotearg.o \
				misc/relocatable.o \
				misc/strverscmp.o \
				misc/timespec.o \
				misc/timevar.o \
				misc/wcwidth.o \
				misc/width.o \
				misc/xalloc-die.o \
				misc/xconcat-filename.o \
				misc/xhash.o \
				misc/xmalloc.o \
				misc/xmemdup0.o \
				misc/xstrndup.o \
				misc/xtime.o \
				misc/bitset/array.o \
				misc/bitset/list.o \
				misc/bitset/stats.o \
				misc/bitset/table.o \
				misc/bitset/vector.o \
				misc/glthread/lock.o \
				misc/glthread/threadlib.o \
				misc/glthread/tls.o
OUTPUT1=libcommon.a

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
