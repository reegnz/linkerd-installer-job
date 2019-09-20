FROM alpine as download

RUN apk add curl
RUN curl -L https://github.com/linkerd/linkerd2/releases/download/stable-2.5.0/linkerd2-cli-stable-2.5.0-linux -o linkerd
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.4/bin/linux/amd64/kubectl

RUN chmod +x kubectl
RUN chmod +x linkerd

FROM alpine
WORKDIR installer
COPY --from=download /linkerd /usr/local/bin/linkerd
COPY --from=download /kubectl /usr/local/bin/kubectl

COPY ./install.sh .
CMD ["./install.sh"]
