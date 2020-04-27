FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copiar csproj y restaurar dependencias del proyecto
COPY *.csproj ./
RUN dotnet restore

# copiar los ficheros del proyecto ...
COPY . ./
# ... y construir
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# copiar desde el proyecto construido (en el destino) a otro dir. del propio destino
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "my_kubweb.dll"]
