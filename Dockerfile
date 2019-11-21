# Base image Debian stretch python 3.6
FROM python:3.7.4-slim-buster

# Update Ubuntu Software repository
RUN apt-get update
RUN apt-get install -y vim

# Upgrade pip
RUN pip install --upgrade pip

# Create folder structure and install requirements
RUN mkdir -p /tester
RUN mkdir -p /tester/output

ADD ./requirements.txt /tester
WORKDIR /tester
RUN pip3 install -r requirements.txt

# Add code and update the working directory
ADD . /tester
WORKDIR /tester
VOLUME /tester

# Run the application with unbuffered output to see it on real time
ENV PYTHONPATH "${PYTHONPATH}:/tester:/tester/module1:/tester/module2"
# CMD /tester/pipeline.sh
CMD /tester/pipeline.sh
