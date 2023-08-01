FROM node:18-alpine as development

WORKDIR /app

COPY package*.json ./
COPY yarn.lock ./
RUN yarn
COPY . .

CMD [ "yarn", "dev" ]

FROM development as build

RUN yarn build

FROM development as dev-envs
RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends git
EOF

RUN <<EOF
useradd -s /bin/bash -m vscode
groupadd docker
usermod -aG docker vscode
EOF
# install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /
CMD [ "npm", "start" ]


FROM nginx:1.21.0-alpine
COPY --from=build /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
