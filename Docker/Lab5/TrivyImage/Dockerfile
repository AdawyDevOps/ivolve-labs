FROM node:24-alpine

WORKDIR /app

COPY package.json ./

RUN npm install --omit=dev \
    && npm cache clean --force \
    && rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/corepack /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack

COPY app.js ./

EXPOSE 3000

CMD ["node", "app.js"]
