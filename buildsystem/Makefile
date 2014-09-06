#
#   Configuration parts of GNU Make build system
#   Copyright (C) 2013 by KO Myung-Hun <komh@chollian.net>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation; either version 2.1 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
#

##### Configuration parts that you can modify
CC       = gcc
CFLAGS   = -Wall
CXX      = g++
CXXFLAGS = -Wall
LD       = g++
LDFLAGS  = -Zomf
LIBS     =

ifdef RELEASE
CFLAGS   += -O3
CXXFLAGS += -O3
STRIP     = lxlite /B- /L- /CS
else
CFLAGS   += -O0 -g -DDEBUG
CXXFLAGS += -O0 -g -DDEBUG
LDFLAGS  += -g
STRIP     = echo
endif

RC      = rc
RCFLAGS = -n

RM = rm -f

# specify a program name
PROGRAM     =
# specify a extension of a program. .exe or .dll
PROGRAM_EXT = .exe

# specify a extension of a object file. .o or .obj
OBJ_EXT = .o

# define to 1 if you don't use RC file
#NO_USE_RC  = 1
# define to 1 if you don't use DEF file
#NO_USE_DEF = 1

# specify C source files
CSRCS   =
# specify C++ source files
CXXSRCS =

include Makefile.common

