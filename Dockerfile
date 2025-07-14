FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

RUN ls -la build/web/

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

RUN ls -la /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]