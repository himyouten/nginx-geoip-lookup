# nginx-geoip-lookup
Nginx based GeoIP lookup web service end point

## Overview

`iso3166.csv` - ISO 3166 country codes in csv format, taken from http://dev.maxmind.com/geoip/legacy/codes/iso3166/

`bin/create_html.sh` - creates the country code json response files that will be sent for a geoip lookup request

`conf/geoip-lookup.conf` - the nginx conf file for the geoip lookup service

`conf/geoip-lookup-cors.include` - optional config for cors response - taken from https://gist.github.com/algal/5480916

## Create the json files

Go to where you want to store the files, usually where Nginx stores its html, e.g. `/usr/share/nginx/html/geoip-lookup`

Execute `create_html.sh` passing it the `iso3166.csv` file.  The script will create one file for each country code, e.g. AD, "Andorra" will create AD.json with the following contents:
```
{ "code": 200, "message": "OK", "data": { "country": { "code" : "AD" } } }
```

## Set up nginx

Copy the `geoip-lookup.conf` config file to `/etc/nginx/conf.d/` and modify for your domain.  Optionally add the CORS include file too.  Don't forget to modify for your domain also.

`geoip-lookup.conf` has two server blocks.  The first one is only really required if CORS is required as it changes the cache key to include `$http_origin` also.  If CORS is not required - though probably a bad idea! - then only the second server block is required as Nginx performance would be about the same doing the file lookup for the json file or the cached response.