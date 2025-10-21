# 🚀 Быстрый старт - UniFi CLI

## Авторизация клиента (самое важное!)

### Базовая команда
```bash
./authorize-client.sh <MAC-адрес> <минуты>
```

### 📌 Топ-7 команд для авторизации

```bash
# 1. Авторизовать на 1 час (60 минут):
./authorize-client.sh 3c:84:6a:12:45:8f 60

# 2. Авторизовать на 24 часа (1440 минут):
./authorize-client.sh 3c:84:6a:12:45:8f 1440

# 3. Авторизовать на неделю (10080 минут):
./authorize-client.sh 3c:84:6a:12:45:8f 10080

# 4. Авторизовать на 1 час с ограничением скорости загрузки 2000 kbps:
./authorize-client.sh 3c:84:6a:12:45:8f 60 up=2000

# 5. Авторизовать на 2 часа с обоими ограничениями скорости:
./authorize-client.sh 3c:84:6a:12:45:8f 120 up=2000 down=5000

# 6. Авторизовать на 1 час с ограничением трафика 100 MB:
./authorize-client.sh 3c:84:6a:12:45:8f 60 bytes=100

# 7. Полный набор ограничений (2 часа, скорости, трафик 500 MB):
./authorize-client.sh 3c:84:6a:12:45:8f 120 up=2000 down=5000 bytes=500
```

## ⏱️ Таблица времени

| Время    | Минуты | Команда с 1 часом                            |
|----------|--------|----------------------------------------------|
| 30 мин   | 30     | `./authorize-client.sh MAC 30`              |
| 1 час    | 60     | `./authorize-client.sh MAC 60`              |
| 2 часа   | 120    | `./authorize-client.sh MAC 120`             |
| 4 часа   | 240    | `./authorize-client.sh MAC 240`             |
| 8 часов  | 480    | `./authorize-client.sh MAC 480`             |
| 12 часов | 720    | `./authorize-client.sh MAC 720`             |
| 24 часа  | 1440   | `./authorize-client.sh MAC 1440`            |
| 3 дня    | 4320   | `./authorize-client.sh MAC 4320`            |
| 7 дней   | 10080  | `./authorize-client.sh MAC 10080`           |
| 30 дней  | 43200  | `./authorize-client.sh MAC 43200`           |

## 🔧 Другие полезные команды

### Список устройств
```bash
# Список всех устройств
./unifi --list all

# Список точек доступа
./unifi --list ap
```

### Управление устройствами
```bash
# Перезагрузить устройство
./unifi --reboot 44:d9:e1:99:99:99

# Обновить устройство
./unifi --upgrade 44:d9:e1:99:99:99

# Постепенная перезагрузка всех точек доступа
./unifi -R --reboot

# Постепенное обновление всех точек доступа
./unifi -R --upgrade
```

### Режим отладки
```bash
# Включить детальное логирование
./unifi -d --list all
./authorize-client.sh 3c:84:6a:12:45:8f 60
```

## 📖 Справка

### Получить помощь
```bash
./unifi -h
./authorize-client.sh
```

### Версия
```bash
./unifi -v
```

## 🔑 Конфигурация

Файл: `unifi.conf`
```bash
username=admin
password=your_password
baseurl=https://192.168.1.1:8443
site=default
```

## 📚 Полная документация

- [AUTHORIZATION_GUIDE.md](AUTHORIZATION_GUIDE.md) - Подробное руководство по авторизации
- [README.md](README.md) - Основная документация
- [doc/](doc/LOGGING.md) - Документация по логированию

## ❗ Частые проблемы

### Не могу авторизоваться
```bash
# Проверьте настройки в unifi.conf
cat unifi.conf

# Проверьте доступность контроллера
ping <IP-адрес-контроллера>
```

### Клиент не получает доступ
1. Проверьте правильность MAC-адреса
2. Клиент должен переподключиться к Wi-Fi
3. Убедитесь, что гостевой портал включен на контроллере

### Ошибка "Config file not found"
```bash
# Создайте конфигурационный файл
cp unifi.conf.dist unifi.conf
# Отредактируйте его
nano unifi.conf
```

---

💡 **Совет:** Для быстрого доступа создайте alias:
```bash
echo "alias unifi-auth='/home/peektoseen/Загрузки/unifi-cli/authorize-client.sh'" >> ~/.bashrc
source ~/.bashrc

# Теперь можно использовать:
unifi-auth 3c:84:6a:12:45:8f 60
```

