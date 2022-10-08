.PHONY: test error clean update firefox lo

error:
	@echo "Please choose one of the following target: update, test, firefox, lo"

all: update test firefox lo

update:
	@echo "Update bo.dic with tibetan-spellchecker data"
	rm -rf tmp-tibetan-spellchecker-git
	git clone git@github.com:eroux/tibetan-spellchecker.git tmp-tibetan-spellchecker-git
	wc -l tmp-tibetan-spellchecker-git/syllables/*.txt |grep total | cut -d' ' -f2 > bo.dic
	cat tmp-tibetan-spellchecker-git/syllables/*.txt >> bo.dic
	rm -rf tmp-tibetan-spellchecker-git

test:
	@echo "All the following lines should be stars:\n"
	hunspell -d bo -a tests/pass.txt
	@echo "\nNone the following lines should be stars:\n"
	hunspell -d bo -a tests/fail.txt

firefox:
	$(MAKE) -C firefox

lo:
	$(MAKE) -C lo

clean:
	rm -rf tmp-tibetan-spellchecker-git
	$(MAKE) -C firefox clean
	$(MAKE) -C lo clean
	$(MAKE) -C debian clean
