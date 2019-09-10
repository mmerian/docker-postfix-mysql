FROM mmerian/postfix

RUN apt-get update && \
    apt-get install -y --no-install-recommends postfix-mysql && \
    apt-get clean
