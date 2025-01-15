CC=/opt/wasi-sdk/bin/clang

all: install

.PHONY: install
install: build
	mkdir -p install install/lib install/include
	cp ./xz/liblzma.so install/lib
	ln -s $(PWD)/xz/src/liblzma/api/lzma/ install/include
	ln -s $(PWD)/xz/src/liblzma/api/lzma.h install/include

.PHONY: build
build:
	cd ./xz && \
		CC=${CC} cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=$(PWD)/build -DENABLE_THREADS=OFF . && \
			cmake --build . --target liblzma

.PHONY: clean
clean:
	rm -rf ./install
	make -C ./xz clean

