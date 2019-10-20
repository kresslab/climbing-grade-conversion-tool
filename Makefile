.PHONY: all build deploy

build:
	elm-app build

deploy: build
	./scripts/deploy.sh
