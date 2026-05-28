FROM openjdk:21-slim

# Устанавливаем необходимые пакеты (curl для скачивания, wget для ядра, screen для консоли)
RUN apt-get update && apt-get install -y curl wget screen && rm -rf /var/lib/apt/lists/*

WORKDIR /server

# Скачиваем ядро Paper 1.21.1
RUN wget -O server.jar https://downloads.papermc.io/v2/projects/paper/versions/1.21.1/builds/120/downloads/paper-1.21.1-120.jar

# Соглашаемся с EULA
RUN echo "eula=true" > eula.txt

# Копируем наш прокачанный скрипт запуска
COPY start.sh /server/start.sh
RUN chmod +x /server/start.sh

# Открываем порты: 25565 (Java) и 19132 (Geyser Bedrock)
EXPOSE 25565
EXPOSE 19132

CMD ["/server/start.sh"]
