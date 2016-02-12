
#### Requirements
- Docker 1.9+

#### Build and Run
```
docker build -t openam .
docker run --name openam -p 8443:8443 -d openam
```

#### Build Arguments
- OPENAM_VERSION (default: 13.0.0)
- OPENAM_KEYSTORE_PASSWORD (default: changeit)

##### Example:
```
docker build --build-arg OPENAM_VERSION=12.0.0 --build-arg OPENAM_KEYSTORE_PASSWORD=secret -t openam .
docker run --name openam -p 8443:8443 -d openam
```

#### URL
<https://localhost:8443/openam>
