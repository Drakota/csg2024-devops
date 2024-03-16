FROM rust:1.75-alpine3.19 AS builder
WORKDIR /usr/src/rusters

COPY . .

RUN apk add --no-cache pkgconf openssl-dev musl-dev
ENV OPENSSL_DIR=/usr
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo build --release

FROM alpine:3.19.1 AS final
COPY --from=builder /usr/src/rusters/target/release/rusters /usr/local/bin

# Use a low privilege user

EXPOSE 5000
CMD ["rusters"]
