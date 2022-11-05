FROM proget.makedeb.org/docker/makedeb/makedeb:ubuntu-latest

RUN sudo apt install -y jq curl git cargo cmake desktop-file-utils pkg-config python3 rustc nodejs 
RUN sudo useradd --uid 1001 --create-home runner

USER runner