FROM hashicorp/terraform:0.12.19

# update alpine packages
RUN apk update

# install awscli
RUN apk add python3
RUN pip3 install --upgrade pip
RUN pip3 install awscli

# install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v1.17.2/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
