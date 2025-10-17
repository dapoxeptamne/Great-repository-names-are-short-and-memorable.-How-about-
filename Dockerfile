FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p static/css static/js templates model logs modelki

COPY modelki/ ./modelki/
COPY modelki/*.py ./

COPY templates/ ./templates/
COPY static/ ./static/

EXPOSE 5050

CMD ["uvicorn", "ehh:app", "--host", "0.0.0.0", "--port", "5050"]