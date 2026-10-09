# Top-level Makefile driving the CMake build. Run ./configure first.

-include config.mk

PACKAGE  = RPi-PowerControl-Lib
VERSION ?= 0.1.0
DISTNAME = $(PACKAGE)-$(VERSION)

.PHONY: all check install clean distclean dist distcheck

all: config.mk
	cmake --build $(BUILD_DIR)

config.mk:
	@echo "Run ./configure first" >&2; exit 1

check: all
	ctest --test-dir $(BUILD_DIR) --output-on-failure

install: all
	cmake --install $(BUILD_DIR)

clean:
	-cmake --build $(BUILD_DIR) --target clean

distclean:
	rm -rf $(BUILD_DIR) config.mk $(DISTNAME) $(DISTNAME).tar.gz

# Source tarball from the tracked files in the working tree.
dist:
	rm -rf $(DISTNAME) && mkdir $(DISTNAME)
	git ls-files | tar cf - -T - | (cd $(DISTNAME) && tar xf -)
	tar czf $(DISTNAME).tar.gz $(DISTNAME)
	rm -rf $(DISTNAME)

# Unpack the tarball and verify it configures, builds and passes checks.
distcheck: dist
	rm -rf $(DISTNAME) && tar xzf $(DISTNAME).tar.gz
	cd $(DISTNAME) && ./configure && $(MAKE) && $(MAKE) check
	rm -rf $(DISTNAME)
	@echo "$(DISTNAME).tar.gz is ready for distribution"
