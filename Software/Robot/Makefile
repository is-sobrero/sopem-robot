# Copyright 2020 I.S. "A. Sobrero" - SoRobot Team. All rights reserved.
# Use of this source code is governed by the GPL 3.0 license that can be
# found in the LICENSE file.

REQUIRED_BINS = python pip ampy
objects = config.json motors.py pm10_sense.py umqttsimple.py main.py

.PHONY: check install

check:
	$(foreach bin,$(REQUIRED_BINS),\
	    $(if $(shell command -v $(bin) 2> /dev/null),$(info Found `$(bin)`),$(error Please install `$(bin)`)))

install: check
ifeq ($(port),)
$(error PORT is not set)
endif
	@$(foreach file, $(objects), ampy --port $(port) --baud 115200 -d 5 put $(file);)