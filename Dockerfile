FROM python:3.9.5-alpine

# Setup environment variables
ENV PORT=8080 \
    HOST=0.0.0.0 \
    PYTHONUNBUFFERED=True \
    FLASK_APP=/app/run.py
ARG FLASK_DEBUG=False
ENV FLASK_DEBUG=$FLASK_DEBUG

# Setup file system
WORKDIR /app
RUN chown nobody:nogroup /app
COPY --chown=nobody:nogroup app/ /app

# Upgrade pip & install python packages (runned as root!)
RUN pip install --upgrade pip --requirement /app/requirements.txt

# Indicate which port to expose
EXPOSE $PORT

# Setting up default process owner and group
USER nobody:nogroup

# Start app server
CMD flask run --host=$HOST --port=$PORT