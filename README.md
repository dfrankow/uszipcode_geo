Take zipcode boundaries out of uszipcode data, and make it into
geojson and topojson files.

Zip code is not actually a geographical designation. Rather, it is
where the US Post Office delivers mail. So, no mail delivery, no zip
code.  So, the maps have holes.  The U.S. Census has a more
geographical concept of Zip Code Tabulation Areas, or ZCTAs, but they
are not in this project.


There is a Makefile for the conversions, but the initial
print_zip_geojson.py you have to run yourself.

# To print geojson for zip5

```
$ virtualenv
$ source .venv/bin/activate
$ pip install -r requirements
$ ./print_zip_geojson.py > json/zip5.geojson
```

# To convert to topojson

```
$ npm install topojson-server
$ export PATH=$PATH:`pwd`/node_modules/topojson-server/bin/
$ export NODE_OPTIONS="--max-old-space-size=8192"
$ geo2topo zipcodes=json/zip5.geojson > json/zip5.topojson
```

# To merge zipcodes into zip3

```
$ npm install topojson-client
$ export PATH=$PATH:`pwd`/node_modules/topojson-client/bin/
$ topomerge zip3=zipcodes -k 'd.properties.zip5.slice(0,3)' < json/zip5.topojson > json/zip3.topojson
```



# See also

- mapshaper.org
- pypi.org/project/uszipcode/
- github.com/topojson/topojson-client/blob/master/README.md#topomerge
