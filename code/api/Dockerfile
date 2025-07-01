FROM python:3.11-slim

RUN apt-get update && apt-get install -y locales && \
    sed -i '/de_CH.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

    ENV LANG=de_CH.UTF-8
ENV LC_ALL=de_CH.UTF-8

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]