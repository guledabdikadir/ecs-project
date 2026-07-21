# Stage 1 - Builder
FROM node:20-alpine AS build

WORKDIR /app

COPY app/package.json app/yarn.lock ./

RUN yarn install

COPY app/ .

ENV DISABLE_ESLINT_PLUGIN=true

RUN yarn build

# Stage 2 - Runtime
FROM node:20-alpine AS runtime

RUN npm install -g serve

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=build --chown=appuser:appgroup /app/build /app/build

USER appuser

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]