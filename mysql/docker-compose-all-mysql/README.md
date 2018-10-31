Create all mysql-server docker container.
====

## Support MySQL version.

- MySQL v5.5
- MySQL v5.6
- MySQL v5.7
- MySQL v8.0
- mariadb v10.0
- mariadb v10.1
- mariadb v10.2
- mariadb v10.3

This docker-compose.yml support mysql and mariadb.

## Usage

### Install docker for mac

All docker software is installed when I install docker for mac or windows.

https://www.docker.com/docker-mac
https://www.docker.com/docker-windows

### Install mysql-client for local-machine

Install mysql client only for Mac OSX.
```bash
$ brew upgrade
$ brew install mysql --client-only
```

It is not necessary to install mysql-server.

### Clone this repository

```bash
git clone git@github.com:treetips/docker-compose-all-mysql.git
```

### Create and start mysql docker containers

```bash
$ docker-compose up -d
```

### Connect any mysql-server on docker container

Connect remote mysql servers.

```bash
# Connect mysql v5.5
$ mysql -h127.0.0.1 -P3355 -uworker -pworker work

# Connect mysql v5.6
$ mysql -h127.0.0.1 -P3356 -uworker -pworker work

# Connect mysql v5.7
$ mysql -h127.0.0.1 -P3357 -uworker -pworker work

# Connect mysql v8.0
$ mysql -h127.0.0.1 -P3380 -uworker -pworker work

# Connect mariadb v10.0
$ mysql -h127.0.0.1 -P3310 -uworker -pworker work

# Connect mariadb v10.1
$ mysql -h127.0.0.1 -P3311 -uworker -pworker work

# Connect mariadb v10.2
$ mysql -h127.0.0.1 -P3312 -uworker -pworker work

# Connect mariadb v10.3
$ mysql -h127.0.0.1 -P3313 -uworker -pworker work
```

## Optional

### Edit my.cnf for MySQL v5.5

```bash
$ vi mysql5.5/conf.d/my.cnf
```

### Edit my.cnf for MySQL v5.6

```bash
$ vi mysql5.6/conf.d/my.cnf
```

### Edit my.cnf for MySQL v5.7

```bash
$ vi mysql5.7/conf.d/my.cnf
```

### Edit my.cnf for MySQL v8.0

```bash
$ vi mysql8.0/conf.d/my.cnf
```

### Edit my.cnf for mariadb v10.0

```bash
$ vi mariadb10.0/conf.d/my.cnf
```

### Edit my.cnf for mariadb v10.1

```bash
$ vi mariadb10.1/conf.d/my.cnf
```

### Edit my.cnf for mariadb v10.2

```bash
$ vi mariadb10.2/conf.d/my.cnf
```

### Edit my.cnf for mariadb v10.3

```bash
$ vi mariadb10.3/conf.d/my.cnf
```

### Edit default schema, user, password

If you change database-schema or user or password or root-password, Edit docker-compose.yml.

```yml
- MYSQL_DATABASE=work
- MYSQL_USER=worker
- MYSQL_PASSWORD=worker
- MYSQL_ROOT_PASSWORD=root
```

# Edit client settings

```bash
vi my.cnf
```

### Re-create mysql containers

```bash
# Stop mysql containers.
$ docker-compose down
Stopping mysql5.5 ... done
Stopping mysql5.6 ... done
Stopping mysql5.7 ... done
Stopping mysql8.0 ... done
Stopping mariadb10.0 ... done
Stopping mariadb10.1 ... done
Stopping mariadb10.2 ... done
Stopping mariadb10.3 ... done

# Create and start mysql containers.
$ docker-compose up -d
```
