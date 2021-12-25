FROM i386/centos:6

# yumのリポジトリをi386向けに変更する
RUN sed -i 's/$basearch/i386/g' /etc/yum.repos.d/CentOS-*.repo && \
    ln -sf /usr/share/zoneinfo/Japan /etc/localtime

# CentOS6.x系はyumリポジトリの場所が変更になっているため設定を書き換える。
RUN cp -p /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak
RUN sed -i -e "s|mirror\.centos\.org/centos/\$releasever|vault\.centos\.org/6.10|g" /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i -e "s|#baseurl=|baseurl=|g" /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-Base.repo_bak

# root work
RUN yum update -y
RUN yum install -y sudo

# install latest stable git
RUN yum -y install \
git \
gcc \
curl-devel \
expat-devel \
gettext-devel \
openssl-devel \
zlib-devel \
perl-ExtUtils-MakeMaker && \
git clone https://github.com/git/git.git && \
cd git/ && \
git checkout `git tag | sort -V | grep -v "\-rc" | tail -1` && \
yum -y remove git && \
make prefix=/usr all && \
make prefix=/usr install && \
cd / && \
rm -rf /git

# intstall ocaml
RUN yum install -y ocaml \
    && git clone https://github.com/sadnessOjisan/min-caml.git

