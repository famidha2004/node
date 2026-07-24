FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM tomcat:10.1-jdk21

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY --from=build /app/dist /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD ["catalina.sh","run"]
