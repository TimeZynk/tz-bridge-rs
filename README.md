# Rust API generator for timezynk-bridge-models

To generate and publish a new version, first update the version number on the API specification
at https://github.com/TimeZynk/bridge-api-spec. Next make sure that you have a valid token
connected to crates.io by using `cargo login`. Finally run:
```
make publish
```
(Docker required)
