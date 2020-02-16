FROM python:3

RUN apt-get update 
RUN apt-get install -y python3-pip git 
RUN pip install flask elasticsearch future

RUN useradd -M -u 1000 flasker

RUN git clone https://github.com/brandeis-llc/dtriac-webapp --branch 1906demo /site
RUN chmod +x /site/run.sh
RUN chown -R flasker /site

EXPOSE 4000/tcp

USER flasker
WORKDIR /site

CMD /site/run.sh
