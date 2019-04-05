FROM hashicorp/terraform:0.11.11

# update all packages
RUN apk update

# install openssl for checksum validation
RUN apk add openssl

# https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html#install-kubectl-linux
RUN curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl
RUN curl -o kubectl.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl.sha256
RUN if [ $(openssl sha -sha256 kubectl | cut -d " " -f 2) != $(cat kubectl.sha256 | cut -d " " -f 1) ] ; then echo "kubectl sha256 did not match" ; exit ; fi
RUN chmod +x ./kubectl
RUN mv ./kubectl /bin/kubectl
RUN kubectl version --short --client

# https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
RUN curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator.sha256
RUN if [ $(openssl sha -sha256 aws-iam-authenticator | cut -d " " -f 2) != $(cat aws-iam-authenticator.sha256 | cut -d " " -f 1) ] ; then echo "aws-iam-authenticator sha256 did not match" ; exit ; fi
RUN chmod +x ./aws-iam-authenticator
RUN mv ./aws-iam-authenticator /bin/aws-iam-authenticator
RUN aws-iam-authenticator help
