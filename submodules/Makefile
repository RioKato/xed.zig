all: out

compile_commands.json:
	cd xed && bear --output ../$@ -- ./mfile.py install

objlist.txt: compile_commands.json
	ar -t xed/kits/*/lib/libxed.a > $@

libxed.json: compile_commands.json objlist.txt
	python filter.py $^ > $@

out: libxed.json
	python collect.py $< $@
	cp -rf xed/kits/*/include/xed out/include
