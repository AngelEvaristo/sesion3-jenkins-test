restore:
    dotnet restore    

build:
    dotnet build --configuration Release

test:
    dotnet test --no-build --verbosity normal
    
publish:
    dotnet publish --configuration Release --output published
    