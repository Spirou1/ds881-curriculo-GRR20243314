FROM node:22-alpine

# O diretório de trabalho deve ser criado pelo root para podermos mudar a permissão depois
WORKDIR /app

# Copiamos apenas os arquivos de dependência primeiro para aproveitar o cache do Docker
COPY package*.json ./

# Garantimos que o usuário 'node' é o dono da pasta /app antes de mudar para ele
RUN chown -R node:node /app

# Agora mudamos para o usuário 'node' (segurança e conformidade)
USER node

# Instalamos as dependências como usuário 'node'
RUN npm install

# Copiamos o restante dos arquivos do projeto garantindo o dono correto
COPY --chown=node:node . .

# Expõe a porta do Astro
EXPOSE 8080

# Comando para iniciar o servidor
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "8080"]
