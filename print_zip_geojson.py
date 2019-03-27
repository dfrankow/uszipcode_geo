#!/usr/bin/env python3

import sys
import uszipcode


def main():
    zipcode_search = uszipcode.SearchEngine(simple_zipcode=False)

    print ("""
{
  "type": "FeatureCollection",
  "features": [
""")
    first = True
    for zip_obj in zipcode_search.by_prefix('', returns=100000):
        if zip_obj.polygon:
            coords = zip_obj.polygon
            # I don't understand why sometimes coords are
            # [[lat,long],[lat,long]...]
            # and sometimes
            # [[[lat,long],[lat,long]...]]
            # but flatten it.
            # (An example of the second is 00612.)
            if type(coords[0][0]) == list and len(coords[0]) != 2:
                print("FLATTEN", file=sys.stderr)
                coords = coords[0]
            if not first:
                print(",")
            print("""
    {
      "type": "Feature",
      "geometry": {
        "type": "Polygon",
        "coordinates": [
            %(polygon_coords)s
        ]
      },
      "properties": {
        "zip5": "%(zip5)s",
        "zip3": "%(zip3)s"
      }
    }
""" % {'polygon_coords': str(coords),
       'zip5': zip_obj.zipcode,
       'zip3': zip_obj.zipcode[:3]})
            first = False
    print("""
  ]
}
""")

main()
