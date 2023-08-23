FROM node:16 as base
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json

# dependencies
FROM base as ui-builder
COPY . /app
RUN npm install
RUN npm run build

# production environment
FROM nginx:1.17.1-alpine
COPY --from=ui-builder /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
