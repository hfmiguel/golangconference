#Dockerfile
FROM golang:1.16 AS build

WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 go build -o /bin/project

# Etapa de execução
FROM scratch
COPY --from=build /bin/project /bin/project
ENTRYPOINT ["/bin/project"]
