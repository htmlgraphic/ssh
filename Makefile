# Build a container via the command "make build"
# By Jason Gegere <jason@htmlgraphic.com>

all:: build


build:
	docker build --rm -t htmlgraphic/ssh:latest .
push:
	docker push htmlgraphic/ssh:latest
