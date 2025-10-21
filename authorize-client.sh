#!/bin/bash

# Скрипт для авторизации MAC-адреса клиента на контроллере UniFi

# Проверка аргументов
if [ $# -lt 2 ]; then
    echo "Использование: $0 <MAC-адрес> <минуты> [up=kbps] [down=kbps] [bytes=MB]"
    echo ""
    echo "Примеры:"
    echo "  $0 aa:bb:cc:dd:ee:ff 60              # Авторизовать на 60 минут"
    echo "  $0 aa:bb:cc:dd:ee:ff 1440            # Авторизовать на 24 часа (1440 минут)"
    echo "  $0 aa:bb:cc:dd:ee:ff 60 up=2000      # С ограничением скорости загрузки 2000 kbps"
    echo "  $0 aa:bb:cc:dd:ee:ff 60 down=5000    # С ограничением скорости скачивания 5000 kbps"
    echo "  $0 aa:bb:cc:dd:ee:ff 60 bytes=100    # С ограничением трафика 100 MB"
    echo ""
    exit 1
fi

# Получаем директорию скрипта
SCRIPT=$(realpath $0)
DIR=$(dirname $SCRIPT)

# Загружаем конфигурацию
if [ ! -f "$DIR/unifi.conf" ]; then
    echo "ОШИБКА: Файл конфигурации не найден: $DIR/unifi.conf"
    exit 1
fi

source "$DIR/unifi.conf"

# Загружаем API библиотеки
source "$DIR/unifi_sh_api"
source "$DIR/unifi_sh_api_nonofficial"

# Параметры
MAC=$1
MINUTES=$2
shift 2
ADDITIONAL_PARAMS="$@"

echo "================================================"
echo "  Авторизация клиента на контроллере UniFi"
echo "================================================"
echo "MAC-адрес: $MAC"
echo "Длительность: $MINUTES минут"
if [ -n "$ADDITIONAL_PARAMS" ]; then
    echo "Дополнительные параметры: $ADDITIONAL_PARAMS"
fi
echo "Контроллер: $baseurl"
echo "Сайт: $site"
echo "================================================"
echo ""

# Авторизация на контроллере
echo "Авторизация на контроллере..."
unifi_login > /dev/null || {
    echo "ОШИБКА: Не удалось авторизоваться на контроллере"
    exit 1
}

echo "Авторизация клиента..."
result=$(unifi_authorize_guest $MAC $MINUTES $ADDITIONAL_PARAMS)

echo "$result"

# Проверка результата
if echo "$result" | grep -q '"meta":{"rc":"ok"}'; then
    echo ""
    echo "✓ УСПЕШНО: Клиент $MAC авторизован на $MINUTES минут"
else
    echo ""
    echo "✗ ОШИБКА: Не удалось авторизовать клиента"
    echo "Ответ сервера: $result"
fi

# Выход из контроллера
echo ""
echo "Выход из контроллера..."
unifi_logout > /dev/null

echo "Готово!"

