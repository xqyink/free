FROM ubuntu
USER root
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install build-ess* wine qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox gnome-system-monitor mate-system-monitor git xfce4 xfce4-terminal tightvncserver wget net-tools nano vim -y
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN wget https://az764295.vo.msecnd.net/stable/2ccd690cbff1569e4a83d7c43d45101f817401dc/code_1.80.2-1690491597_amd64.deb
RUN wget https://az764295.vo.msecnd.net/stable/2ccd690cbff1569e4a83d7c43d45101f817401dc/vscode_cli_alpine_x64_cli.tar.gz
RUN tar zxvf vscode_cli_alpine_x64_cli.tar.gz
RUN apt-get install -y ./code_1.80.2-1690491597_amd64.deb
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir  $HOME/.vnc
RUN echo 'F5d8b8516a16' | vncpasswd -f > $HOME/.vnc/passwd
RUN echo '/bin/env  MOZ_FAKE_NO_SANDBOX=1  dbus-launch xfce4-session'  > $HOME/.vnc/xstartup
RUN chmod 600 $HOME/.vnc/passwd
RUN chmod 755 $HOME/.vnc/xstartup
RUN echo 'whoami ' >>/luo.sh
RUN echo 'cd ' >>/luo.sh
RUN echo "su -l -c 'vncserver :2000 -geometry 1360x768' "  >>/luo.sh
RUN echo "/code tunnel --cli-data-dir . --accept-server-license-terms &" >> /luo.sh
RUN echo 'cd /noVNC-1.2.0' >>/luo.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 8900 ' >>/luo.sh
RUN chmod 755 /luo.sh
EXPOSE 8900
CMD  /luo.sh 
