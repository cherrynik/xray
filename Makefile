build:
	docker build -t domain-list-community .

generate:
	docker run --rm \
		-v "$(shell pwd)/output:/app/output" \
		domain-list-community \
		sh -c "go run ./ --datapath=./input && cp dlc.dat ./output/custom.dat"