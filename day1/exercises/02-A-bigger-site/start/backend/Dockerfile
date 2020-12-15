FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS build


# TODO: add the Docker commands to do these build steps:

# set the current directory to /src
WORKDIR /src
# copy the manifest file: backend.csproj
COPY backend.csproj .
# from a shell, run `dotnet restore backend.csproj`
RUN dotnet restore backend.csproj
# copy the content into place
COPY . .
# from a shell, run `dotnet build backend.csproj -c Release`
RUN dotnet build backend.csproj -c Release
# from a shell, run `dotnet publish backend.csproj -c Release -o /app`
RUN dotnet publish backend.csproj -c Release -o /app


FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

ENV ASPNETCORE_URLS http://+:5000
EXPOSE 5000


# TODO: add the Docker commands to do these image build and container run steps:

# set the current directory to /app
WORKDIR /app
# copy the content from the app folder on the build stage above (https://docs.docker.com/develop/develop-images/multistage-build/)
COPY --from=build /app .

# as the container starts:
# `dotnet backend.dll`
CMD ["dotnet", "backend.dll"]
