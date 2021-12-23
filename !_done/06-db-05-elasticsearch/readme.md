# 

## 1 
1. текст Dockerfile манифеста
    
    ```
    FROM centos:7
    RUN yum -y upgrade && yum -y install wget sudo
    RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.0-linux-x86_64.tar.gz \
    && tar -xzf elasticsearch-7.16.0-linux-x86_64.tar.gz && rm elasticsearch-7.16.0-linux-x86_64.tar.gz
    RUN cp -r elasticsearch-7.16.0 /usr/share/
    RUN groupadd -r elk && useradd -r -g elk elk
    RUN echo "elk ALL=NOPASSWD: ALL" >> /etc/sudoers
    RUN mkdir /var/lib/elasticsearch
    COPY elasticsearch.yml /usr/share/elasticsearch-7.16.0/config
    RUN chown -R elk:elk /usr/share/elasticsearch-7.16.0
    RUN chown -R elk:elk /var/lib/elasticsearch
    ENTRYPOINT [ "/usr/bin/su", "-c", "/usr/share/elasticsearch-7.16.0/bin/elasticsearch", "elk" ]
    
    ```
1. ответ elasticsearch на запрос пути / в json виде  
    ```buildoutcfg
    {
      "name" : "netology_test",
      "cluster_name" : "netology-elk",
      "cluster_uuid" : "DOp30ysWS96nu2sZRSCLcg",
      "version" : {
        "number" : "7.16.0",
        "build_flavor" : "default",
        "build_type" : "tar",
        "build_hash" : "6fc81662312141fe7691d7c1c91b8658ac17aa0d",
        "build_date" : "2021-12-02T15:46:35.697268109Z",
        "build_snapshot" : false,
        "lucene_version" : "8.10.1",
        "minimum_wire_compatibility_version" : "6.8.0",
        "minimum_index_compatibility_version" : "6.0.0-beta1"
      },
      "tagline" : "You Know, for Search"
    }
    
    ```
1. [Docker hub](https://hub.docker.com/r/kocmoc1/06-db-05-elasticsearch)


## 2

Так как Elasticsearch в single mode ему некуда скижывать реплики, пожтому там где реплики >0 статус желтый.

    ```buildoutcfg
    green  open .geoip_databases KNtGs42ESimbjW-kqd4NVw 1 0 42 0 41.1mb 41.1mb
    green  open ind-1            E1pvccg6S0yCupLu-ZzpNw 1 0  0 0   226b   226b
    yellow open ind-3            _iOIxTOoQ3OiX3ax2gDXMg 4 2  0 0   904b   904b
    yellow open ind-2            C_1r0upsSDis-RDUj9ALzg 2 1  0 0   452b   452b
    
    ```
  http://localhost:9200/_cluster/health/
   
    ```buildoutcfg
    {"cluster_name":"netology-elk","status":"yellow","timed_out":false,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":10,"active_shards":10,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":10,"delayed_unassigned_shards":0,"number_of_pending_tasks":0,"number_of_in_flight_fetch":0,"task_max_waiting_in_queue_millis":0,"active_shards_percent_as_number":50.0}
    ```
    
## 3
    ```buildoutcfg
    Invoke-WebRequest -URI "http://localhost:9200/_snapshot/netology_backup?pretty" -Method PUT -Header @{"Content-Type"="application/json"} -Body '{ "type": "fs",  "settings": { "location": "/usr/share/elasticsearch-7.16.0/snapshots", "compress": true }}'
      
    
    StatusCode        : 200
    StatusDescription : OK
    Content           : {
                          "acknowledged" : true
                        }
    
    RawContent        : HTTP/1.1 200 OK
                        X-elastic-product: Elasticsearch
                        Warning: 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91b8658ac17aa0d "Elasticsearch built-in
                        security features are not enabled. Without authent...
    Forms             : {}
    Headers           : {[X-elastic-product, Elasticsearch], [Warning, 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91
                        b8658ac17aa0d "Elasticsearch built-in security features are not enabled. Without authentication, yo
                        ur cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/referen
                        ce/7.16/security-minimal-setup.html to enable security."], [Content-Length, 28], [Content-Type, app
                        lication/json; charset=UTF-8]}
    Images            : {}
    InputFields       : {}
    Links             : {}
    ParsedHtml        : System.__ComObject
    RawContentLength  : 28
    ```
    
  Список индексов (test):
    
    ```buildoutcfg
    Invoke-WebRequest -URI "http://localhost:9200/_cat/indices" -Method GET
    
    StatusCode        : 200
    StatusDescription : OK
    Content           : green open .geoip_databases 6zfObsmNTBaEAxmoSgFsjw 1 0 42 0 41.1mb 41.1mb
                        green open test             U6h82bNjSpqWNK8R23mSqw 1 0  0 0   226b   226b
    
    ```
    
   Список файлов
   ```
sh-4.2# ls -la /usr/share/elasticsearch-7.16.0/snapshots/
total 40
drwxr-xr-x 1 elk elk 4096 Dec 12 12:27 .
drwxr-xr-x 1 elk elk 4096 Dec 12 12:17 ..
-rw-r--r-- 1 elk elk 1429 Dec 12 12:27 index-0
-rw-r--r-- 1 elk elk    8 Dec 12 12:27 index.latest
drwxr-xr-x 6 elk elk 4096 Dec 12 12:27 indices
-rw-r--r-- 1 elk elk 9686 Dec 12 12:27 meta-MHolT0xVR6CWrLQYq8ZN2Q.dat
-rw-r--r-- 1 elk elk  458 Dec 12 12:27 snap-MHolT0xVR6CWrLQYq8ZN2Q.dat
sh-4.2#
   ```

  Список индексов (test-2)
  
  ```buildoutcfg
Invoke-WebRequest -URI "http://localhost:9200/_cat/indices/" -Method GET
>>


StatusCode        : 200
StatusDescription : OK
Content           : green open test-2           OzcvR5pPRyC3tlaPpdCWZg 1 0  0 0   226b   226b
                    green open .geoip_databases 6zfObsmNTBaEAxmoSgFsjw 1 0 42 0 41.1mb 41.1mb

RawContent        : HTTP/1.1 200 OK
                    X-elastic-product: Elasticsearch
                    Warning: 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91b8658ac17aa0d "Elasticsearch built-in
                    security features are not enabled. Without authent...
Forms             : {}
Headers           : {[X-elastic-product, Elasticsearch], [Warning, 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91
                    b8658ac17aa0d "Elasticsearch built-in security features are not enabled. Without authentication, yo
                    ur cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/referen
                    ce/7.16/security-minimal-setup.html to enable security."], [Content-Length, 148], [Content-Type, te
                    xt/plain; charset=UTF-8]}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 148

```

 Восстановление и список индексов после.
```buildoutcfg
>> Invoke-WebRequest -URI "http://localhost:9200/_snapshot/netology_backup/netology_snapshot/_restore?pretty" -Method POST -Header @{"Content-Type"="application/json"} -Body '{  "indices": "test", "include_global_state": false}'


StatusCode        : 200
StatusDescription : OK
Content           : {
                      "accepted" : true
                    }

RawContent        : HTTP/1.1 200 OK
                    X-elastic-product: Elasticsearch
                    Warning: 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91b8658ac17aa0d "Elasticsearch built-in
                    security features are not enabled. Without authent...
Forms             : {}
Headers           : {[X-elastic-product, Elasticsearch], [Warning, 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91
                    b8658ac17aa0d "Elasticsearch built-in security features are not enabled. Without authentication, yo
                    ur cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/referen
                    ce/7.16/security-minimal-setup.html to enable security."], [Content-Length, 24], [Content-Type, app
                    lication/json; charset=UTF-8]}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 24



 Invoke-WebRequest -URI "http://localhost:9200/_cat/indices/" -Method GET
>>


StatusCode        : 200
StatusDescription : OK
Content           : green open test-2           OzcvR5pPRyC3tlaPpdCWZg 1 0  0 0   226b   226b
                    green open .geoip_databases 6zfObsmNTBaEAxmoSgFsjw 1 0 42 0 41.1mb 41.1mb
                    green open test             nyT0rXAZS3-KxCz5oQLEPA 1...
RawContent        : HTTP/1.1 200 OK
                    X-elastic-product: Elasticsearch
                    Warning: 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91b8658ac17aa0d "Elasticsearch built-in
                    security features are not enabled. Without authent...
Forms             : {}
Headers           : {[X-elastic-product, Elasticsearch], [Warning, 299 Elasticsearch-7.16.0-6fc81662312141fe7691d7c1c91
                    b8658ac17aa0d "Elasticsearch built-in security features are not enabled. Without authentication, yo
                    ur cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/referen
                    ce/7.16/security-minimal-setup.html to enable security."], [Content-Length, 222], [Content-Type, te
                    xt/plain; charset=UTF-8]}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 222

```

