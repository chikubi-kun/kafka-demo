all:
	@echo targets:
	@echo "    restart      stop and start docker compose (zookeeper and kafka)"
	@echo "    start        start docker compose (zookeeper and kafka) and wait until all are up"
	@echo "    stop         shutdown docker compose (zookeeper and kafka)"

restart: stop start

start: compose-up
	@sh bin/wait.sh "localhost:2181,localhost:9092,localhost:9093,localhost:9094,localhost:6379"
	@sh bin/wait-kafka.sh "kafka1:9092,kafka2:9093,kafka3:9094"

stop: compose-down

compose-up:
	@docker-compose up -d

compose-down:
	@docker-compose down