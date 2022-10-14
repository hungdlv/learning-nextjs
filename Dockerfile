FROM node:12-buster as builder
WORKDIR /app

COPY package.json .
COPY package-lock.json .
COPY prisma prisma

RUN npm install

COPY . .

RUN npm run build && npm prune --production


FROM node:12-buster-slim
WORKDIR /app

RUN apt-get -qy update
RUN apt-get -qy install openssl

COPY --from=builder /app .

EXPOSE 4000

CMD ["npm", "start"]
