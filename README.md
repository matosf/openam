
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

#### Usage
After building and running the image the OpenAM interface can be found at: <https://localhost:8443/openam>.

In the Docker image itself the SSOAdminTools (with utilities like `ampassword`) can be found in `/root/ssoadmintools`. Since the SSOAdminTools are tied to a specific OpenAM instances you need to run `setup` in the Docker image after you have completed the OpenAM setup.
