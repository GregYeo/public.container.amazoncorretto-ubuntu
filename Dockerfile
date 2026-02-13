FROM ubuntu:24.04

RUN apt update -y && \
    apt install -y \
    curl gnupg2 software-properties-common && \
    curl -s https://apt.corretto.aws/corretto.key | apt-key add - && \
    add-apt-repository 'deb https://apt.corretto.aws stable main' && \
    apt-get install -y java-21-amazon-corretto-jdk && \
    apt-get clean all && \
    java --version

ENV JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto

COPY ./data/non_root_user_entrypoint.sh /non_root_user_entrypoint.sh

ENTRYPOINT ["/non_root_user_entrypoint.sh"]
