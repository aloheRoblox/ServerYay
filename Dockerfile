FROM openjdk:21-slim
RUN apt-get update && apt-get install -y wget curl && rm -rf /var/lib/apt/lists/*
WORKDIR /minecraft
RUN curl -o /usr/local/bin/playit -L https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && chmod +x /usr/local/bin/playit
RUN wget https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/120/downloads/paper-1.21.1-120.jar -O server.jar
RUN echo "eula=true" > eula.txt
RUN echo "online-mode=false" > server.properties
RUN echo "server-port=25565" >> server.properties
RUN echo '#!/bin/bash\nplayit & \njava -Xmx5G -Xms5G -jar server.jar nogui\n' > start.sh
RUN chmod +x start.sh
CMD ["./start.sh"]
