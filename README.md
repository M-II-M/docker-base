# Базовая настройка SSL с Certbot

Этот репозиторий предоставляет базовую настройку для конфигурирования SSL с использованием Certbot и Nginx.
Начало работы

## Начало работы

### 1. Получение SSL-сертификата

Перед получением SSL-сертификата убедитесь, что домен в вашей конфигурации Nginx совпадает с доменом, для которого вы запрашиваете сертификат.

**Важно**: 
> [!IMPORTANT]
> Временно закомментируйте редирект на HTTPS в вашей конфигурации Nginx, чтобы избежать петель редиректа во время выпуска сертификата.

Используйте следующую команду для получения SSL-сертификата:
```bash
docker compose run certbot certonly --webroot -w /var/www/certbot --force-renewal --email example@gmail.com -d example.ru --agree-tos
```

**Примечание**:
> [!WARNING]
> Домен (example.ru) должен совпадать с доменом, указанным в вашей конфигурации Nginx.
> 
> После нескольких неудачных попыток вы можете быть временно забанены на час.


### 2. Обновление SSL-сертификата

Чтобы автоматизировать обновление вашего SSL-сертификата, вы можете настроить задачу cron.

Установите cron, если он еще не установлен:

```bash
sudo apt-get install cron
```

Откройте редактор crontab:

```bash
crontab -e
```

Добавьте следующую строку, чтобы запланировать задачу обновления:

```
0 0 1 */1 * cd /path/to/project && docker compose run --rm certbot renew >> /path/to/project/cron.log
```

Эта задача cron будет пытаться обновить сертификат 1-го числа каждого месяца и записывать вывод в файл cron.log.


### Дополнительные примечания

> [!IMPORTANT]
> Убедитесь, что ваша конфигурация Nginx правильно настроена для обслуживания домена перед попыткой получения SSL-сертификата.
> 
> Мониторьте файл cron.log на наличие ошибок или успешных обновлений.
