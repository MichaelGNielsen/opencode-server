# Dockerfile til OpenCode Server
FROM node:20-slim

# Installer systemafhængigheder
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Installer OpenCode AI globalt
RUN npm install -g opencode-ai

# Eksponer server-porten
EXPOSE 4096

# Start serveren (Jf. din instruks)
CMD ["opencode", "serve", "--port", "4096", "--hostname", "0.0.0.0"]
