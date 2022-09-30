# Guide for creating your own `open route service` app with Croatian (Geofabrik) routing database loaded

This guide is in Croatian language.

The database file can be obtained from Geofabrik at: <https://download.geofabrik.de/europe/croatia.html>

## Guide to setup a dockerized server HTTP REST API

Profil routing mape je postavljen u app.config u `profile` čvoru na `walking`.

1. Pokrenuti defaultnu docker skriptu u direktoriju ovog dokumenta (ona sa githuba je to <https://github.com/GIScience/openrouteservice/tree/master/docker>):

    ```ps1
    docker run -dt --name ors-app -p 8080:8080 `
    -v $PWD/graphs:/ors-core/data/graphs `
    -v $PWD/elevation_cache:/ors-core/data/elevation_cache `
    -v $PWD/conf:/ors-conf `
    -v $PWD/croatia-latest.osm.pbf:/ors-core/data/osm_file.pbf `
    -e "JAVA_OPTS=-Djava.awt.headless=true -server -XX:TargetSurvivorRatio=75 -XX:SurvivorRatio=64 -XX:MaxTenuringThreshold=3 -XX:+UseG1GC -XX:+ScavengeBeforeFullGC -XX:ParallelGCThreads=4 -Xms1g -Xmx2g" `
    -e "CATALINA_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9001 -Dcom.sun.management.jmxremote.rmi.port=9001 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost" `
    openrouteservice/openrouteservice:latest
    ```

2. Pričekati da se app pokrene u dockeru, provjeriti na localhost 8080 jel se upalio Tomcat server i provjeriti health endpoint jel vraća status ready: `http://localhost:8080/ors/v2/health`

3. Kad ste provjerili da je ready i vraća JSON odgovor za `http://localhost:8080/ors/v2/directions/foot-walking?start=18.08804543299171,42.65709339685951&end=18.106246932775903,42.641991395820725` onda treba napraviti image iz tog kontejnera sa: `docker commit ors-app ors-app-croatia-temp`, nakon toga imate novi image, provjera sa: `docker images` i vidite ors-app-croatia-temp image

4. Radite novi image koji će pregaziti bazu i app.cofig sa Dockerfileom iz ovog direktorija: `docker build -t ors-app-croatia .`, prije toga osigurati da imate croatia.osm.pbf u root direktoriju preuzet s Geofabrika

5. Testirate lokalno je li image radi: `docker run --rm -dt --name ors-app-cro-1 -p 0.0.0.0:8080:8080 ors-app-croatia`, pucate `http://localhost:8080/ors/v2/health` dok ne vidite da je ready nakon 2-5 minuta, probate i `http://localhost:8080/ors/v2/directions/foot-walking?start=18.08804543299171,42.65709339685951&end=18.106246932775903,42.641991395820725`, te ako sve radi trebalo bi i u cloudu.

6. Imate image koji možete pushati u gitlab/azure container registry i na azureu pokrenuti kontejner iz njega

## Prebuilt docker image

You can use the image from docker hub: `$ docker pull vmandic/ors-app-croatia:latest`

## Updates

Last update performed 2022-09-30. Had to redo whole thing and repush :latest tag. New config is used with walking only profile.
