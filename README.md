Take zipcode boundaries out of uszipcode data, and make it into
geojson and topojson files.

# To print geojson for zip5

```
$ virtualenv
$ source .venv/bin/activate
$ pip install -r requirements
$ ./print_zip_geojson.py > zip5.geojson
```

# To convert to topojson

```
$ npm install topojson-server
$ export PATH=$PATH:`pwd`/node_modules/topojson-server/bin/
$ geo2topo zipcodes=zip5.geojson > zip5.topojson
```

# To merge zipcodes into zip3

```
$ npm install topojson-client
$ export PATH=$PATH:`pwd`/node_modules/topojson-client/bin/
$ topomerge zip3=zipcodes -k 'd.properties.zip5.slice(0,3)' < zip5.topojson > zip3.topojson
```



# See also

- https://pypi.org/project/uszipcode/
- https://github.com/topojson/topojson-client/blob/master/README.md#topomerge


d is  { type: 'Polygon',
  arcs: [ [ -11, 12 ] ],
  properties: { zip5: '00623', zip3: '006' } }
