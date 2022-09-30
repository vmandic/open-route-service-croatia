docker run -dt -u "${UID}:${GID}" \
  --name ors-app \
  -p 8080:8080 \
  -v $PWD/graphs:/ors-core/data/graphs \
  -v $PWD/elevation_cache:/ors-core/data/elevation_cache \
  -v $PWD/conf:/ors-conf \
  -v $PWD/croatia-latest.osm.pbf:/ors-core/data/osm_file.pbf \  # your local PBF file
  -e "JAVA_OPTS=-Djava.awt.headless=true -server -XX:TargetSurvivorRatio=75 -XX:SurvivorRatio=64 -XX:MaxTenuringThreshold=3 -XX:+UseG1GC -XX:+ScavengeBeforeFullGC -XX:ParallelGCThreads=4 -Xms1g -Xmx2g" \
  -e "CATALINA_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9001 -Dcom.sun.management.jmxremote.rmi.port=9001 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost" \
  openrouteservice/openrouteservice:latest