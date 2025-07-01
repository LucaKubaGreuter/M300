#!/bin/bash

DOMAIN="weatherappm300.duckdns.org"

sudo certbot --nginx \
  -d $DOMAIN \
  --non-interactive \
  --agree-tos \
  -m lucagr07@icloud.com
