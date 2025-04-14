FROM golang:alpine

# Install Git in the container (Git is needed to clone the repository)
RUN apk update && apk add git

# Set working directory inside the container
WORKDIR /app

# Clone the project repository from GitHub
RUN git clone https://github.com/v2fly/domain-list-community.git .

# Download all the project dependencies
RUN go mod download

# Expose a volume if you need to map a custom data directory
VOLUME ["custom/"]

# Default command:
# This command generates dlc.dat using the data files in the repository's "data" directory.
# To use a custom data path, override the command when running the container.
ENTRYPOINT ["go", "run", "./"]
