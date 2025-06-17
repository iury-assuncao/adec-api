FROM node:22-alpine

# Define o diretório de trabalho
WORKDIR /usr/src/app

# Copia package.json e package-lock.json para instalar dependências
COPY package*.json ./

# Instala todas as dependências (prod + dev)
RUN npm install

# Copia todo o código para o container
COPY . .

# Expõe a porta padrão do NestJS
EXPOSE 3000

# Usa o comando de desenvolvimento para ativar hot reload
CMD ["npm", "run", "start:dev"]
