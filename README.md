# Templates for bakdata Projects

This repository contains some files that bakdata usually needs in open source projects, e.g. Travis setup or Gradle configs.

Currently, this repository contains templates for:
 - Java projects with Gradle ([java-gradle](https://github.com/bakdata/bakdata-project-templates/tree/master/java-gradle))

## How to Use It
This repository contains a script that will fetch all templates and guide you through the process of setting up your new project.

The easiest way to do this is with the following command in the directory of your project:
```sh
bash -c "$(curl -sL https://raw.githubusercontent.com/bakdata/bakdata-project-templates/master/init.sh)"
```