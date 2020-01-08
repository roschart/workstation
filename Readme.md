# Code-server version updated to my necesities

This repository create a image of [code-server](https://github.com/cdr/code-server) with the plugins and things that I need in my normal day with visual code

* [ ] Go
* [x] Node
* [ ] Haskell
* [ ] Markdown
* [x] Haskell
* [ ] Python


# How to use

* Build : `docker build --tag=roschart/workstation .`
* Push : `docker push roschart/workstation`

## Run
cmd-der: `docker run -it -p 127.0.0.1:8080:8080 -v "${PWD}:/home/coder/project" roschart/workstation /home/coder/project --auth none`

console: `docker run -it -v "${PWD}:/home/coder/project" --entrypoint "bash" roschart/workstation`


