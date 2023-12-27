# Every instruction in an image creates a cacheable layer - layers help with image re-building and sharing.
FROM node
#the parent image - node
# create dir, and will copy on it (can reference by .)
WORKDIR /app

# copy file to workdirectory to install node
COPY package.json .

# run command during he build
RUN npm install

# copy everything else o the workdir (can be use "." instead of "/app")
COPY . /app

# just anotation that we will use 80 port, here it has no impact
EXPOSE 80

# will execute by run container
CMD ["node", "server.js"]