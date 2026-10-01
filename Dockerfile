FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DEBUG=0 \
    DATABASE_PATH=/home/user/app/data/db.sqlite3

# Hugging Face runs containers as a non-root user (id 1000)
RUN useradd -m -u 1000 user
USER user
WORKDIR /home/user/app

COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt
ENV PATH="/home/user/.local/bin:$PATH"

COPY --chown=user . .
RUN mkdir -p data && python manage.py collectstatic --noinput

EXPOSE 7860
CMD ["sh", "start.sh"]
