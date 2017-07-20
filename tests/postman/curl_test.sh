#!/bin/bash

# Run:
# ./curl_test.sh http://conda:8080
# ./curl_test.sh https://capdf.csiro.au/aemvl-backend

URL_ROOT=$1

echo '' > cookies.txt

curl \
    -c cookies.txt \
    -H "Accept: text/csv" \
    -F "project_id=TESTPROJECT" \
    -F "datafile=@../../docs/AUS_10004_CSIRO_EM_HM_reduced.XYZ" \
    -F "configfile=@../../docs/AUS_10004_CSIRO_SkyTem_EM.json" \
    "${URL_ROOT}/api/upload"

curl \
    -b cookies.txt \
    -c cookies.txt \
    -H "Accept: text/csv" \
    -F "project_id=TESTPROJECT" \
    "${URL_ROOT}/api/getLines"

curl \
    -b cookies.txt \
    -c cookies.txt \
    -H "Accept: text/csv" \
    -F "project_id=TESTPROJECT" \
    -F "line_number=200301" \
    -F "column_names=HM_Z,PLNI" \
    "${URL_ROOT}/api/getLine"

curl \
    -b cookies.txt \
    -c cookies.txt \
    -H "Accept: text/csv" \
    -F "project_id=TESTPROJECT" \
    -F "line_number=200301" \
    -F "component_name=HM_Z" \
    -F "fiducials_and_masks=[[261069.7,[0,-1,0,0,0,-1,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,0,0,0,-1,0,0,-1,0]],[261069.6,[0,-1,0,0,0,-1,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,0,0,0,-1,0,0,-1,0]]]" \
    "${URL_ROOT}/api/applyMask"

curl \
    -b cookies.txt \
    -c cookies.txt \
    -H "Accept: text/csv" \
    -F "project_id=TESTPROJECT" \
    -F "line_number=200301" \
    -F "column_names=HM_Z,PLNI" \
    "${URL_ROOT}/api/getLine"
