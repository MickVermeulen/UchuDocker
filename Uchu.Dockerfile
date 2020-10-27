FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine
COPY Uchu config.default.xml .env cert.pfx* ./

RUN apk update && apk add --no-cache gettext && apk add --no-cache curl

RUN set -o allexport && source .env && set +o allexport && envsubst < config.default.xml > config.xml
RUN dotnet build --configuration Release

ENTRYPOINT ["dotnet", "Uchu.Master/bin/Release/netcoreapp3.1/Uchu.Master.dll"]