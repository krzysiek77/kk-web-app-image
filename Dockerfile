FROM mcr.microsoft.com/dotnet/runtime:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["MyFirstAzureWebApp/MyFirstAzureWebApp.csproj", "MyFirstAzureWebApp/"]
RUN dotnet restore "MyFirstAzureWebApp/MyFirstAzureWebApp.csproj"
COPY . .
WORKDIR "/src/MyFirstAzureWebApp"
RUN dotnet build "MyFirstAzureWebApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MyFirstAzureWebApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MyFirstAzureWebApp.dll"]