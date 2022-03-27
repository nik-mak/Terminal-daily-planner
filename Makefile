.default: hachi

.PHONY: hachi
hachi:
	ruby planner.rb

.PHONY: test
test:
	rspec ./spec/dateandtimes_spec.rb -f d 
