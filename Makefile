.PHONY: generate publish

CARGO_TOKEN := $(shell tail -n1 ~/.cargo/credentials | cut -d\" -f2)

generate:
	docker build -t timezynk-bridge-models .

build:
	docker rm bridge-builder
	docker run --name bridge-builder timezynk-bridge-models cargo build --release
	docker cp bridge-builder:/opt/timezynk-bridge-models .tmp
	docker rm bridge-builder

publish: generate
	docker run --rm timezynk-bridge-models cargo publish --token ${CARGO_TOKEN}

yank: generate
	docker run --rm timezynk-bridge-models cargo yank --undo --vers 0.0.1 --token ${CARGO_TOKEN}
