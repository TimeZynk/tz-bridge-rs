.PHONY: generate publish

CARGO_TOKEN := $(shell tail -n1 ~/.cargo/credentials | cut -d\" -f2)

generate:
	docker build -t timezynk-bridge-models .

publish: generate
	docker run --rm -v ${HOME}/.cargo:/root/.cargo timezynk-bridge-models cargo publish --token ${CARGO_TOKEN}

