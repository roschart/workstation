# Code-server version updated to my necesities

This repository create a image of [code-server](https://github.com/cdr/code-server) with the plugins and things that I need in my normal day with visual code

* [x] Git
* [ ] Go
* [ ] KubeCtl
* [x] Haskell
* [x] Hugo
* [x] Node
* [x] Python
* [ ] Rust


# How to use

* Build : `docker build --tag=roschart/workstation .`
* Push : `docker push roschart/workstation`

## Run
### Console
`docker run -it -v "${PWD}:/home/coder/project" --entrypoint "bash" roschart/workstation`
or
`docker-compose run --service-ports --entrypoint bash coder`
### cmd-der
cmd-der: `docker run -it -p 127.0.0.1:8080:8080 -p 1313:1313 -v "${PWD}:/home/coder/project" roschart/workstation /home/coder/project --auth none`



### To use HUGO
Open a terminal inside code-server and run 

`hogo server -b 0.0.0.0` you can now go to your site in localhost:1313