#!/bin/sh
#
# === Xkeen Xray Backup Script ===
#
# Назначение:
#   Скрипт выполняет резервное копирование конфигурации Xray на роутере (Keenetic/Entware)
#   и отправляет архив с бэкапом на удалённый сервер по SSH (SFTP через dbclient).
#
# Использование:
#   1. Настроить SSH-доступ к серверу (по ключу).
#   2. Разместить скрипт на роутере, например в /opt/scripts/xray_backup_send.sh
#   3. Сделать исполняемым: chmod +x /opt/scripts/xray_backup_send.sh
#   4. Для автоматизации добавить в cron (например, каждую пятницу в 03:00).
#
# Примечание:
#   В скрипте предполагается, что у вас установлен Xkeen, dbclient и Perl (для очистки ANSI-кодов).
#   Работает только при корректно настроенном SSH-ключе.
#

# === Настройки SSH ===
SSH_KEY="${SSH_KEY:-/opt/root/.ssh/id_rsa}"
SSH_PORT="${SSH_PORT:-10022}"
SSH_USER="${SSH_USER:-your_user}"
SSH_HOST="${SSH_HOST:-your_host}"
REMOTE_DIR="${REMOTE_DIR:-/home/backups/your_dir}"

# === Локальная папка для бэкапов ===
BACKUP_DIR="/opt/backups"

# === 1. Создаём резервную копию Xray конфигов ===
BACKUP_NAME=$(
  xkeen -cb \
  | perl -pe 's/\x1B\[[0-9;]*[A-Za-z]//g' \
  | grep "Резервная копия конфигурации Xray создана:" \
  | awk '{print $6}'
)

LATEST_BACKUP="$BACKUP_DIR/$BACKUP_NAME"

if [ -z "$BACKUP_NAME" ] || [ ! -d "$LATEST_BACKUP" ]; then
  echo "❌ Бэкап не найден" | tee -a /opt/backups/backup.log
  exit 1
fi

echo "✅ Найден бэкап: $LATEST_BACKUP" | tee -a /opt/backups/backup.log

# === 2. Архивируем и отправляем ===
ARCHIVE_NAME="backup_$(date +%F_%H-%M).tar.gz"

tar -C "$BACKUP_DIR" -czf - "$(basename "$LATEST_BACKUP")" \
| dbclient -i "$SSH_KEY" -p $SSH_PORT ${SSH_USER}@${SSH_HOST} \
"mkdir -p $REMOTE_DIR && cat > $REMOTE_DIR/$ARCHIVE_NAME"

if [ $? -eq 0 ]; then
  echo "✅ Бэкап успешно отправлен: $ARCHIVE_NAME" | tee -a /opt/backups/backup.log
else
  echo "❌ Ошибка при отправке бэкапа" | tee -a /opt/backups/backup.log
fi
