FROM debian:buster-slim as builder
ARG  ARCHIVE_FILE
ARG  EXTRACT_DIR
COPY ${ARCHIVE_FILE} /
RUN  tar xf /${ARCHIVE_FILE} 

FROM openjdk:11.0.14.1-jre-slim-buster
ARG  EXTRACT_DIR
COPY --from=builder /${EXTRACT_DIR}/ /kafka/ 
COPY entrypoint.sh /
ENV PATH ${PATH}:/kafka/bin
WORKDIR /kafka 
ENTRYPOINT ["/entrypoint.sh"] 
CMD bash



