# Stage 1: Builder
FROM golang:alpine AS builder

# Install Git and other needed tools
RUN apk update && apk add --no-cache git

# Set working dir
WORKDIR /app

# Clone the repo
RUN git clone https://github.com/v2fly/domain-list-community.git .

# Build the project
RUN go install .

COPY ./custom /app/custom

# Default command — uses the repo’s internal data unless overridden
CMD ["go", "run", "./"]
