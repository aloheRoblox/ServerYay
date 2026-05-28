#!/bin/bash

# Создаем папку для плагинов
mkdir -p plugins

echo "Скачиваем плагины..."
curl -L -o plugins/ViaVersion.jar https://modrinth.com/mgapi/v1/project/viaversion/version/latest/download
curl -L -o plugins/ViaBackwards.jar https://modrinth.com/mgapi/v1/project/viabackwards/version/latest/download
curl -L -o plugins/Geyser-Spigot.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot

# Настройка online-mode=false
if [ ! -f server.properties ]; then
    echo "online-mode=false" > server.properties
else
    sed -i 's/online-mode=true/online-mode=false/g' server.properties
fi

# Запуск сервера
screen -dmS mc_server java -Xmx4G -Xms4G -jar server.jar nogui

echo "Ждем прогрузки для выдачи опки..."
sleep 40

# Выдача опки
screen -S mc_server -X stuff "op aloheRoblox\n"
echo "Опка выдана!"

tail -f logs/latest.log
