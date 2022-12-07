FROM      python

WORKDIR   /app 

ADD       . /app 

RUN       pip install -r requirements.txt
RUN       pip install --upgrade pip

EXPOSE    80

CMD [ "python", "app.py" ]