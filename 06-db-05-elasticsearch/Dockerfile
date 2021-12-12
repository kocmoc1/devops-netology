FROM centos:7
RUN yum -y upgrade && yum -y install wget sudo
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.0-linux-x86_64.tar.gz \
&& tar -xzf elasticsearch-7.16.0-linux-x86_64.tar.gz && rm elasticsearch-7.16.0-linux-x86_64.tar.gz
RUN cp -r elasticsearch-7.16.0 /usr/share/
RUN groupadd -r elk && useradd -r -g elk elk
RUN echo "elk ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /var/lib/elasticsearch
RUN mkdir /usr/share/elasticsearch-7.16.0/snapshots
COPY elasticsearch.yml /usr/share/elasticsearch-7.16.0/config
RUN chown -R elk:elk /usr/share/elasticsearch-7.16.0
RUN chown -R elk:elk /var/lib/elasticsearch
ENTRYPOINT [ "/usr/bin/su", "-c", "/usr/share/elasticsearch-7.16.0/bin/elasticsearch", "elk" ]