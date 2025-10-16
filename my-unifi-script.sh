#!/bin/bash

# Функция для логирования
script_log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SCRIPT-$level] $*" >&2
}

script_log_info() {
    script_log "INFO" "$@"
}

script_log_debug() {
    if [ "$DEBUG" == "true" ]; then
        script_log "DEBUG" "$@"
    fi
}

script_log_info "Запуск скрипта UniFi"

## config
script_log_info "Загрузка конфигурации: unifi.conf"
. unifi.conf

## include the API library
script_log_info "Загрузка библиотек API"
. unifi_sh_api
. unifi_sh_api_nonofficial

## Login
script_log_info "Авторизация в UniFi Controller"
unifi_login


##--------------------
## Custom commands
##--------------------

## Download controller configuration backup (unifi-backup.unf)
#unifi_backup

## List connections
#unifi_list_sta | python -m json.tool

## Reboot a device
#unifi_reboot_dev 44:d9:e1:99:99:99

## List devices
#unifi_list_dev | python -m json.tool

## Reboot all devices
#unifi_reboot_all_ap

#unifi_list_ap | jq -r '.data[] | select(.type=="uap") | [.name, .mac]'

## Upgrade custom device
#unifi_upgrade_dev 44:d9:e1:99:99:99

## Start Rolling upgrade
#unifi_ap_rolling_upgrade

##--------------------

## Logout
script_log_info "Выход из UniFi Controller"
unifi_logout
script_log_info "Скрипт завершил работу успешно"
