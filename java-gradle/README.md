[![Build status](https://travis-ci.org/bakdata/{{project-name}}.svg?branch=master)](https://travis-ci.org/bakdata/{{project-name}}/)
[![Sonarcloud status](https://sonarcloud.io/api/project_badges/measure?project=bakdata-{{project-name}}&metric=alert_status)](https://sonarcloud.io/dashboard?id=bakdata-{{project-name}})
[![Code coverage](https://sonarcloud.io/api/project_badges/measure?project=bakdata-{{project-name}}&metric=coverage)](https://sonarcloud.io/dashboard?id=bakdata-{{project-name}})
[![Maven](https://img.shields.io/maven-central/v/com.bakdata.{{project-name}}/{{project-name}}.svg)](https://search.maven.org/search?q=g:com.bakdata.{{project-name}}%20AND%20a:{{project-name}}&core=gav)


{{project-name}}
================


## Getting Started

You can add {{project-name}} via Maven Central.

#### Gradle
```gradle
compile group: 'com.bakdata', name: '{{project-name}}', version: '1.0.0'
```

#### Maven
```xml
<dependency>
    <groupId>com.bakdata</groupId>
    <artifactId>{{project-name}}</artifactId>
    <version>1.0.0</version>
</dependency>
```


For other build tools or versions, refer to the [latest version in MvnRepository](https://mvnrepository.com/artifact/com.bakdata.{{project-name}}/{{project-name}}/latest).

### How to use it

Here are X examples that show you how to use {{project-name}}.

#### Example 1

```java
class ExampleSnippet {
}
```

#### More Examples

You can find many more example in [this repository's XXX code](https://github.com/bakdata/{{project-name}}/xxx).


## Development

If you want to contribute to this project, you can simply clone the repository and build it via Gradle.
All dependencies should be included in the Gradle files, there are no external prerequisites.

```bash
> git clone git@github.com:bakdata/{{project-name}}.git
> cd {{project-name}} && ./gradlew build
```

Please note, that we have [code styles](https://github.com/bakdata/bakdata-code-styles) for Java.
They are basically the Google style guide, with some small modifications.

## Contributing

We are happy if you want to contribute to this project.
If you find any bugs or have suggestions for improvements, please open an issue.
We are also happy to accept your PRs.
Just open an issue beforehand and let us know what you want to do and why.

## License
This project is licensed under the MIT license.
Have a look at the [LICENSE](https://github.com/bakdata/{{project-name}}/blob/master/LICENSE) for more details.
