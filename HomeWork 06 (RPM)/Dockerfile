FROM centos:7

RUN yum -y install http://37.143.13.172:8080/repo/nginx-1.14.2-1.el7_4.ngx.x86_64.rpm

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80/TCP

CMD ["nginx"]
