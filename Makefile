.PHONY: generate publish

CARGO_TOKEN := $(shell tail -n1 ~/.cargo/credentials | cut -d\" -f2)

generate:
	docker build -t timezynk-bridge-models .

publish: generate
	docker run --rm timezynk-bridge-models cargo publish --token ${CARGO_TOKEN}

yank: generate
	docker run --rm timezynk-bridge-models cargo yank --undo --vers 0.0.1 --token ${CARGO_TOKEN}
