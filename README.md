# Main Street Moves Map

A (WIP) simple map app to help folks navigate beautiful downtown Ventura. Stay tuned!

# Running Locally

## Redis

You really must have Redis running to cache Google Places API results, or else everything will load very slowly and you will risk hitting the API lots of times by mistake and charging yourself a bunch of money ($32 per 1000 requests!).

Connecting to Redis in `fly.io`:

```
fly redis connect
```

Alternatively, run your own Redis locally. 

You will need to set a `REDIS_URL` in `.env`. For `fly` proxies, use `redis://default:<password>@localhost:16379` or provide your own.

## Google API Key

You need one, set it in `.env` as `GOOGLE_API_KEY`

## Running the Server

### But first!

`bundle install`

### ... then

`./bin/dev`

## Database

None... yet :)

## Deploying

`fly deploy`
