DIRS = double-int fib primes rand
MAKEFLAGS += --quiet

BINS = main fib primes rand

all: $(BINS)

main: 
	@$(MAKE) -C double-int
	@mv double-int/main double-int-bin

fib: 
	@$(MAKE) -C fib
	@mv fib/fib fib-bin

primes: 
	@$(MAKE) -C primes
	@mv primes/primes primes-bin

rand: 
	@$(MAKE) -C rand
	@mv rand/rand rand-bin

clean:
	@for dir in $(DIRS); do \
		$(MAKE) -C $$dir clean; \
	done

.PHONY: main fib primes rand clean
