build:
	docker build -t domain-list-community .

generate:
	docker run --rm \
		-v "$(pwd)/output:/app/output" \
		domain-list-community \
		sh -c "go run ./ --datapath=./custom && cp dlc.dat ./output/"