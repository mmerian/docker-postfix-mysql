FROM mmerian/postfix

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends postfix-mysql && \
    apt-get clean
