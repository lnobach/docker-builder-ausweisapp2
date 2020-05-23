# docker-builder-ausweisapp2

The [AusweisApp2](https://www.ausweisapp.bund.de/ausweisapp2/) is not officially available for Linux, but the 
official code is prepared for it so you can create a user-friendly application package for a Linux/amd64 
target (Qt-based UI and card reader support included).

This container automatically fetches and builds latest or specific versions of the AusweisApp Community 
Edition (CE) based on the [official sources](https://github.com/Governikus/AusweisApp2), for the Linux 
platform.
The build process is inspired by [this how-to](https://www.nohl.eu/tech-resources/notes-to-linux/ausweisapp2-installation-dummies/),
but some essential parts differ.

Tested with:
- Ubuntu 20.04 (.deb package and raw binary)

Prerequisites: A Linux box with Docker (docker-ce or docker.io) installed. Maybe the builder also supports alternative container managers (e.g. rkt), but they are currently untested.

Like AusweisApp2 itself, this builder is licensed under the EUPL license.

## Build Container Build Instructions

```bash
sudo docker build -t aabuilder:local .
```

## Build Container Run Instructions - How to use the builder

```bash
# Prerequisites
mkdir workspace #this is your working directory which the Docker container uses for persistence
sudo chown 1000:1000 workspace
# Run
sudo docker run -v "$(pwd)/workspace:/workspace" -t aabuilder:dev
```
This will automatically build the latest release (annotated tag) of AusweisApp2. 
To build specific Git refs (other releases, tags, branches, IDs), you can append them 
as an argument to the end of the `docker run` command.
If the build was successful, the results will show up in the subdirectory `workspace/target` and will be versioned.

```
$ tree workspace/target/
workspace/target/
├── 1.20.0
│   ├── AusweisApp2
│   ├── AusweisApp2.rcc
│   ├── config.json
│   └── translations
│       ├── ausweisapp2_de.qm
│       └── qtbase_de.qm
└── ausweisapp_1.20.0.deb
```

Unsuccessful builds will resume where they have ended, and subsequent builds will only build differences.
To obtain clean builds again, delete and recreate the `workspace` directory.

## AusweisApp2 Run Instructions

You can either install the `.deb` package or execute the build's raw binaries via shell (X display needed).

### From the raw binaries

```bash
# Prerequisites
sudo apt-get install qml-module-qtquick-controls2 qml-module-qtqml-models2 #(for Ubuntu 20.04)
# Run
workspace/target/<version>/AusweisApp2
```

### From the .deb package

```
sudo dpkg -i ausweisapp_<version>.deb
```
Alternatively, you can use any graphical DEB package installer.

After installation, you can start AusweisApp 2 via your desktop manager.
