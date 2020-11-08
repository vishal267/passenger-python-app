FROM phusion/passenger-full
MAINTAINER vishal

RUN rm -f /etc/service/nginx/down
RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/nginx/sites-available/default
RUN mkdir /app
ADD  requirements.txt /app
WORKDIR /app

RUN apt update -y ;apt install -y python3-pip
RUN pip3 install -r requirements.txt

ADD nginx.conf /etc/nginx/nginx.conf
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
RUN mkdir /home/app/webapp
ADD Passengerfile.json /home/app/webapp/public/
ADD passenger_wsgi.py /home/app/webapp/public/
COPY --chown=app:app app.py /home/app/webapp/public/

RUN chown app:app -R /home/app/webapp
RUN chmod -R  +x  /home/app


EXPOSE 80
CMD ["/sbin/my_init"]





