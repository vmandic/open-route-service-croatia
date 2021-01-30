# take temp image created from container
FROM ors-app-croatia-temp:latest AS main

# override config and database
COPY ./conf/app.config ./ors-conf/app.config
COPY ./croatia.osm.pbf ./data/osm_file.pbf

# make sure you wait for the container to rebuild the graphs as it changes the database on start