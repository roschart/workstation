#  docker run -it --rm -v c:/Workspace:/workspace registry.payvison.com/jl.balirac/worstation
 docker run -it -p 127.0.0.1:8443:8443 -v "${PWD}:/home/coder/project" registry.payvision.com/jl.balirac/workstation --allow-http --no-auth
