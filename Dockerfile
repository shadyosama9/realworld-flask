FROM python:3.10-slim-bookworm

RUN apt-get update && apt-get install -y \
    curl \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip \
    && pip install --no-cache pipenv \
    && pip install --no-cache poetry

COPY poetry.lock pyproject.toml README.md /app/

WORKDIR /app

COPY realworld /app/realworld

RUN poetry config virtualenvs.create false \
    && poetry install --only main --no-root

ENV FLASK_APP=realworld.app

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
