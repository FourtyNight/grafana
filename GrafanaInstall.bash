#!/bin/bash
#y0_AgAAAAB0BBAwAATuwQAAAAENzY01AAD3gM-LXWNFmI4A4Ac48-xnxfdYQg
# Переменные
GRAFANA_VERSION="8.4.3"
GRAFANA_REPO_FILE="/etc/apt/sources.list.d/grafana.list"
GRAFANA_KEY_URL="https://packages.grafana.com/gpg.key"
GRAFANA_PACKAGE="grafana"

# Функция для добавления репозитория Grafana
add_grafana_repo() {
    echo "Добавление репозитория Grafana..."
    sudo apt-get install -y software-properties-common
    sudo wget -q -O - $GRAFANA_KEY_URL | sudo apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a $GRAFANA_REPO_FILE
}

# Функция для установки Grafana
install_grafana() {
    echo "Обновление списка пакетов..."
    sudo apt-get update

    echo "Установка Grafana..."
    sudo apt-get install -y $GRAFANA_PACKAGE
}

# Функция для настройки и запуска службы Grafana
configure_grafana_service() {
    echo "Перезагрузка демона systemd..."
    sudo systemctl daemon-reload

    echo "Запуск и включение службы Grafana..."
    sudo systemctl start grafana-server
    sudo systemctl enable grafana-server

    echo "Проверка статуса службы Grafana..."
    sudo systemctl status grafana-server
}

# Основная функция
main() {
    echo "Установка и настройка Grafana на Debian 12..."
    add_grafana_repo
    install_grafana
    configure_grafana_service

    echo "Grafana успешно установлена и настроена. Откройте браузер и перейдите на http://localhost:3000 для доступа к Grafana."
}

# Запуск основной функции
main
