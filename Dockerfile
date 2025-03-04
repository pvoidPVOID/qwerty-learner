# Dockerfile (适用于 Vite 项目)
# 阶段 1: 构建
FROM node:16-alpine AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
# 清除缓存并强制重新构建
RUN yarn build


# 阶段 2: 运行
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]