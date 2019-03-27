json/zip3-simple.topojson: json/zip5-simple.topojson
	topomerge zip3=zipcodes -k 'd.properties.zip5.slice(0,3)' < $? > $@

json/zip3.topojson: json/zip5.topojson
	topomerge zip3=zipcodes -k 'd.properties.zip5.slice(0,3)' < $? > $@

json/zip5.topojson: json/zip5.geojson
	geo2topo zipcodes=$? > $@

# This ran for 45 minutes without finishing
#json/zip5-simple-us.topojson: json/zip5-simple.topojson
#	geoproject 'd3.geoAlbersUsa()' < $? > $@

json/zip5-simple.topojson: json/zip5.topojson
	# 4*pi/360 = 0.034906585
	toposimplify -s 0.01 -f < $? > $@

json/zip5.geojson:
	# remove empty lines to enable ndjson-split
	./print_zip_geojson.py | perl -ne 's/\n/ /g; s/ +/ /g; print' > $@

json/zip5.geojson.split: json/zip5.geojson
	ndjson-split 'd.features' < $? > $@

clean_topo:
	rm -f json/zip[35].topojson
