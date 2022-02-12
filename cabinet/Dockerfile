FROM python:3-alpine
RUN apk add --no-cache gcc musl-dev libffi-dev cargo rust openssl-dev
RUN mkdir -p /opt/cabinet

WORKDIR /opt/cabinet
COPY requirements.txt /opt/cabinet
RUN pip install -r requirements.txt
COPY src/ /opt/cabinet/src

COPY entrypoint.sh /opt/cabinet
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/opt/cabinet/entrypoint.sh" ]
