FROM python:3.9.5-alpine

# Setup build args
ARG FLASK_APP=/app/run.py \
    FLASK_DEBUG=False \
    HOST=0.0.0.0 \
    PORT=8080 \
    PYTHONUNBUFFERED=True

# Setup environment variables
ENV FLASK_APP=$FLASK_APP \
    FLASK_DEBUG=$FLASK_DEBUG \
    HOST=$HOST \
    PORT=$PORT \
    PYTHONUNBUFFERED=$PYTHONUNBUFFERED

# Setup file system
WORKDIR /app
RUN chown nobody:nogroup /app
COPY --chown=nobody:nogroup app/ /app

# Upgrade pip & install python packages (runned as root!)
RUN pip install --upgrade pip --requirement /app/requirements.txt

# Indicate which port to expose
EXPOSE $PORT

# # Setting up default process owner and group
# USER nobody:nogroup

# Start app server
CMD flask run --host=$HOST --port=$PORT