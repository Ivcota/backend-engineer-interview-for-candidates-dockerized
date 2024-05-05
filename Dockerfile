# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9.7-slim

EXPOSE 1550

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN python -m pip install poetry

WORKDIR /app
COPY . /app

RUN poetry config virtualenvs.in-project true \
    && poetry install --no-interaction --no-ansi --no-root

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

CMD ["poetry", "run", "python", "-m", "backend_engineer_interview"]