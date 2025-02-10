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

## Connecting from mobile

Use [`ngrok`](https://ngrok.com/)

## Database

None... yet :)

## Deploying

`fly deploy`

# Infrastructure

* Cron job at `cron-job.org` to hit `/up` on a 10 minute timer; this keeps the app running in `fly.io` and also sends an email when the site breaks
* Redis to make load times faster but more importantly to shield from too many requests to the Google Places API
* Fly.io for application hosting

## Cache Refresher

There's a special route, `/cache/refresh`, which will hit Google Places API and update _all_ data in Redis. This ensures that no actual user hits the site and requires a call out to these APIs, which are quite slow. This is gated by HTTP basic auth, and the credentials are stored in environment variables `CACHE_REFRESH_USER` and `CACHE_REFRESH_PASSWORD`