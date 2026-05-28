#!/bin/bash

# Создаем папку для плагинов, если её нет
mkdir -p plugins

echo "Скачиваем плагины для поддержки всех версий и телефонов..."
# Скачиваем ViaVersion
curl -L -o plugins/ViaVersion.jar https://modrinth.com/mgapi/v1/project/viaversion/version/latest/download
# Скачиваем ViaBackwards
curl -L -o plugins/ViaBackwards.jar https://modrinth.com/mgapi/v1/project/viabackwards/version/latest/download
# Скачиваем Geyser-Spigot (для игроков с телефонов)
curl -L -o plugins/Geyser-Spigot.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot

# Настраиваем пиратский режим перед запуском
if [ ! -f server.properties ]; then
    echo "online-mode=false" > server.properties
else
    sed -i 's/online-mode=true/online-mode=false/g' server.properties
fi

# Запускаем сервер в фоне через screen
screen -dmS mc_server java -Xmx4G -Xms4G -jar server.jar nogui

echo "Ждем полной загрузки сервера для выдачи опки..."
# Ждем 40 секунд, пока генерируется мир и стартуют плагины
sleep 40

# Выдаем права оператора на твой ник
screen -S mc_server -X stuff "op aloheRoblox\n"
echo "Команда op aloheRoblox успешно отправлена!"

# Выводим логи в реальном времени
tail -f logs/latest.log
