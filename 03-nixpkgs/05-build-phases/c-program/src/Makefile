all:
	$(CC) hello.c -o hello

check:
	@echo "=== RUNNING TESTS ==="
	./hello | grep -q "hello from default phases"

install:
	mkdir -p "$(out)/bin"
	cp hello "$(out)/bin/hello"
