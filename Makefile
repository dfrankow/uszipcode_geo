json/zip3.topojson: json/zip5.topojson
	topomerge zip3=zipcodes -k 'd.properties.zip5.slice(0,3)' < json/zip5.topojson > json/zip3.topojson

json/zip5.topojson: json/zip5.geojson
	geo2topo zipcodes=json/zip5.geojson > json/zip5.topojson

json/zip5.geojson:
	./print_zip_geojson.py > json/zip5.geojson

clean_topo:
	rm -f json/zip[35].topojson
