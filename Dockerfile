FROM java:8-jre
MAINTAINER Josh VanderLinden <codekoala@gmail.com>

RUN apt-get update && \
    apt-get install -y curl ruby unzip

RUN useradd -m sencha && \
    cd && cp -R .bashrc .profile /home/sencha && \
    mkdir -p /code && \
    chown -R sencha:sencha /home/sencha /code

USER sencha
ENV HOME /home/sencha

RUN curl -Lo $HOME/cmd.run.zip http://cdn.sencha.com/cmd/6.5.1/no-jre/SenchaCmd-6.5.1-linux-amd64.sh.zip && \
    unzip -p $HOME/cmd.run.zip > $HOME/cmd-install.run && \
    chmod +x $HOME/cmd-install.run && \
    INSTALL4J_ADD_VM_PARAMS="-Djava.awt.headless=true" $HOME/cmd-install.run -q -dir $HOME/Sencha/6.5.1 && \
    rm $HOME/cmd-install.run $HOME/cmd.run.zip

ENV PATH $HOME/Sencha/Cmd/6.5.1/:$PATH

WORKDIR /code

EXPOSE 1841

ENTRYPOINT ["/home/sencha/Sencha/6.5.1/sencha"]
CMD ["help"]
