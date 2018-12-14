# gmi
gmi stand for GitModuleInstaller. It allows to install gitmodules while using docker cache

## How to use

### In a Dockerfile
```
From trespetitlegume/gmi as gmi
#Add your private key if some of your dependencies are private
COPY ./id_rsa /root/.ssh/id_rsa
#Any other permissions than 600 will result in a failure
RUN chmod 600 /root/.ssh/id_rsa
#Add your gmi file
COPY .gitmodules .gitmodules.gmi
#Run the script
RUN ./gmi.sh

#then later you can extracts your modules at /gmi/git_modules

COPY --from=gmi /gmi/git_modules /my/git_modules/
```

### From CLI

`docker run trespetitlegume -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v /path/to/.gitmodules/:/gmi/.gitmodules.gmi -v /my/gitmodules/:/gmi/git_modules`


## FYI

- Openssh is configured with StrictHostKeyChecking no to simplify usage