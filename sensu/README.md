## sensu release/5.21

build

```
go build -o bin/sensu-backend ./cmd/sensu-backend
go build -o bin/sensu-agent ./cmd/sensu-agent
go build -o bin/sensuctl ./cmd/sensuctl
```

start

```
./bin/sensu-backend start -c backend.yml

export SENSU_BACKEND_CLUSTER_ADMIN_USERNAME=admin
export SENSU_BACKEND_CLUSTER_ADMIN_PASSWORD=123456

./bin/sensu-backend init -c backend.yml

./bin/sensu-agent start -c agent.yml
```
