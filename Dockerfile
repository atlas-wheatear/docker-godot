FROM barichello/godot-ci:3.3 AS exporter

WORKDIR /export

RUN wget -O godot.zip https://downloads.tuxfamily.org/godotengine/3.3/Godot_v3.3-stable_linux_server.64.zip

RUN unzip godot.zip

RUN mv Godot_v3.3-stable_linux_server.64 server

COPY . .

RUN godot -v --export "Linux/X11" game


FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

WORKDIR /app

COPY --from=exporter /export/game.pck server.pck

COPY --from=exporter /export/server .

CMD [ "./server", "--server" ]
