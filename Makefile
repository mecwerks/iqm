CXXFLAGS= -O3 -fomit-frame-pointer
override CXXFLAGS+= -Wall -fsigned-char

PLATFORM= $(shell uname -s)
ifeq ($(PLATFORM),mingw32)
CXX=i686-w64-mingw32-g++
IQM_BIN=iqm.exe
UPGRADE_BIN=upgrade.exe
LIBS= -mwindows -static -static-libgcc -static-libstdc++
else
IQM_BIN=iqm
UPGRADE_BIN=upgrade
LIBS=
endif

IQM_OBJS= \
	iqm.o

UPGRADE_OBJS= \
	upgrade.o


ifeq ($(V), 1)
Q=
else
Q=@
endif

default: all

all: iqm upgrade

clean:
	$(Q)-$(RM) -r $(IQM_BIN) $(UPGRADE_BIN) $(IQM_OBJS) $(UPGRADE_OBJS)

iqm: $(IQM_OBJS)
	$(Q)$(CXX) $(CXXFLAGS) -o $(IQM_BIN) $(IQM_OBJS) $(LIBS)

upgrade: $(UPGRADE_OBJS)
	$(Q)$(CXX) $(CXXFLAGS) -o $(UPGRADE_BIN) $(UPGRADE_OBJS) $(LIBS)
