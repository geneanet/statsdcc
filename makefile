SHELL := /bin/bash

all: ./build
	@ (cd build >/dev/null 2>&1 && cmake -D test=true ..)
	@ $(MAKE) -C build

debug: ./build
	@ (cd build >/dev/null 2>&1 && cmake -D debug=true -D test=true ..)
	@ $(MAKE) -C build

./build:
	@ mkdir ./build

test: all
	@ (cd build && ctest)

clean:
	@- (cd build >/dev/null 2>&1 && cmake .. >/dev/null 2>&1)
	@- $(MAKE) --silent -C build clean || true
	@- rm -rf ./build/*

lint:
	find ./src ./include ./test -type f | xargs python2.7 ./vendor/cpplint/cpplint.py 2>&1 >/dev/null | grep -v 'No copyright message found'
