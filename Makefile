.default: hachi

.PHONY: hachi
hachi:
	ruby planner.rb

.PHONY: test
test:
	rspec
