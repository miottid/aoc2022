all: run

run: build
	./aoc2022

build:
	nim c -d:release --mm:orc -o:aoc2022 src/aoc2022

test:
	nimble test

clean:
	rm -fr nimcache aoc2022 *.dSYM
	find tests -depth 1 -type f -not -name '*.nim' -delete
