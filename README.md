# Unifi CLI (non-official)

## Instalation

Install requirements:

```sh
apt-get update
apt-get install curl jq realpath

# Download Unifi CLI
git clone https://github.com/xezpeleta/unifi-cli.git

# Optional: add a link to /usr/local/bin
ln -s <download-path>/unifi /usr/local/bin/unifi
```

## Configuration

Rename the file `unifi.conf.dist` to `unifi.conf` and change the following parameters:

```
# Required variables

username=admin
password=unf
baseurl=https://unificontroller:8443
site=default
```

## Usage

```sh
./unifi
```

## Documentation

- [Logging README](doc/README_LOGGING.md) - Быстрый старт с системой логирования 🚀
- [Logging Documentation](doc/LOGGING.md) - Подробная документация по системе логирования
- [Logging Summary](doc/LOGGING_SUMMARY.md) - Краткое описание системы логирования
- [Changelog - Logging](doc/CHANGELOG_LOGGING.md) - История изменений системы логирования

## Resources

I'm using the [UniFi official library](https://dl.ubnt.com/unifi/5.4.11-6cbeae59e7/unifi_sh_api)
