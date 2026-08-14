# rabbitmq

The RabbitMQ message broker backend from [Mainflux](https://github.com/MainfluxLabs/mainflux), removed in favor of NATS-only (JetStream). See [issue #1298](https://github.com/MainfluxLabs/mainflux/issues/1298).

## What's here

- `pkg/messaging/rabbitmq/` — the RabbitMQ implementation of the `messaging.Publisher`/`Subscriber`/`PubSub` interfaces (AMQP-based).
- `pkg/messaging/brokers/rabbitmq.go` — the `-tags rabbitmq` build-time wiring that selected this backend over NATS.

## Status

Extracted as-is from the mainflux repository at the point of removal. It depends on other packages from that module (`pkg/messaging`, `pkg/domain`, `logger`, etc.) and **will not build standalone** without them — this is a reference snapshot, not a standalone module. See the main [legacy README](../README.md) for the general terms.
