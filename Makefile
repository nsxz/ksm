#
# ksm - a really simple and fast x64 hypervisor
# Copyright (C) 2016 Ahmed Samy <f.fallen45@gmail.com>
#
# Makefile for the Linux kernel module only.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; If not, see <http://www.gnu.org/licenses/>.
obj-m += ksmlinux.o
ksmlinux-objs := exit.o htable.o ksm.o page.o vcpu.o main_linux.o vmx.o
ccflags-y := -Wno-format -Wno-declaration-after-statement -Wno-unused-function -DDBG -DENABLE_PRINT -std=gnu99 -DNESTED_VMX

KVERSION := $(shell uname -r)
KDIR := /lib/modules/$(KVERSION)/build
PWD := $(shell pwd)
MAKEFLAGS += --no-print-directory

all:
	make -C $(KDIR) M=$(PWD) modules

clean:
	make -C $(KDIR) M=$(PWD) clean

load:
	insmod ksmlinux.ko

unload:
	rmmod ksmlinux.ko

