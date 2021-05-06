FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install wget unzip -y

WORKDIR /app

RUN wget -O godot.zip https://downloads.tuxfamily.org/godotengine/3.3/Godot_v3.3-stable_linux_server.64.zip

RUN unzip godot.zip

RUN mv Godot_v3.3-stable_linux_server.64 server

COPY server.pck .

CMD [ "./server", "--server" ]
