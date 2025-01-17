# Dockerfile
FROM python:3.12-alpine

# Set the working directory
WORKDIR /MyFinances
# Copy the project files
COPY . .
#COPY ../../requirements.gh_actions.txt requirements.txt
# Install dependencies
RUN apk add --update mariadb-connector-c-dev
RUN apk add --no-cache --virtual .build-deps py-pip musl-dev gcc mariadb-dev
RUN pip install --upgrade pip
RUN pip install mysql
RUN apk add --no-cache git
CMD ["git","--version"]
RUN pip install mariadb
RUN pip install mysqlclient
RUN pip install -r requirements.txt --upgrade

# Set the entrypoint
#COPY ../scripts /infrastructure/scripts/
RUN chmod +x infrastructure/backend/scripts/*
RUN chmod +x infrastructure/backend/scripts/tests/*
ENTRYPOINT ["sh", "infrastructure/backend/scripts/entrypoint.sh"]

# Expose ports
EXPOSE 10012
EXPOSE 9012
