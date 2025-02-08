# Use a minimal base image with Go installed
FROM golang:1.21 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source files
COPY . .

# Build the Go binary
RUN go build -o server

# Use a minimal image for deployment
FROM alpine:latest

WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/server .

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["./server"]
