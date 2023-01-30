FROM golang

RUN apt-get update; apt-get -y install \
    git \
    python3-pip \
    curl \
    vim
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.50.1 && golangci-lint --version
RUN go install github.com/lietu/go-pre-commit@latest
RUN git config --global user.email "you@example.com";
RUN git config --global user.name "Your Name"
RUN pip install pre-commit
RUN pre-commit --version
COPY .pre-commit-config.yaml .
COPY cmd cmd

RUN git init

RUN pre-commit autoupdate
RUN pre-commit migrate-config

RUN git add cmd 

RUN git commit -am Initial
RUN go mod init mytest
# RUN go mod tidy

# RUN pre-commit run --all-files
