# yajsv

[![CI](https://github.com/neilpa/yajsv/workflows/CI/badge.svg)](https://github.com/neilpa/yajsv/actions/)

Yet Another [JSON-Schema](https://json-schema.org) Validator. Command line tool for validating JSON and/or YAML documents against provided schemas.

The real credit goes to [xeipuuv/gojsonschema](https://github.com/xeipuuv/gojsonschema) which does the heavy lifting behind this CLI.

## Installation

Simply use `go install` to install

```
go install github.com/neilpa/yajsv
```

There are also pre-built static binaries for Windows, Mac and Linux on the [releases tab](https://github.com/neilpa/yajsv/releases/latest).

## Usage

Yajsv validates JSON (and/or YAML) documents against a JSON-Schema, providing a status per document:

  * pass: Document is valid relative to the schema
  * fail: Document is invalid relative to the schema
  * error: Document is malformed, e.g. not valid JSON or YAML

The 'fail' status may be reported multiple times per-document, once for each schema validation failure.

Basic usage example

```
$ yajsv -s schema.json document.json
document.json: pass
```

Or with both schema and doc in YAML.

```
$ yajsv -s schema.yml document.yml
document.yml: pass
```

With multiple schema files and docs

```
$ yajsv -s schema.json -r foo.json -r bar.yaml doc1.json doc2.yaml
doc1.json: pass
doc2.json: pass
```

Or with file globs (note the quotes to side-step shell expansion)

```
$ yajsv -s main.schema.json -r '*.schema.json' 'docs/*.json'
docs/a.json: pass
docs/b.json: fail: Validation failure message
...
```

Note that each referenced schema is assumed to be a path on the local filesystem. These are not
URI references to either local or external files.

See `yajsv -h` for more details

## Release

### Install dependency
```
brew install goreleaser
```

### Tag your release
```
git tag -a v1.4.2 -m "v1.4.2: Now with Linux Arm64"
git push origin v1.4.2
```

### Create your GitHub Token
To release to GitHub, you'll need to export a GITHUB_TOKEN environment variable, which should contain a valid GitHub token with the repo scope. It will be used to deploy releases to your GitHub repository. You can create a new GitHub token [here](https://github.com/settings/tokens/new?scopes=repo,write:packages).

The minimum permissions the GITHUB_TOKEN should have to run this are `write:packages`

### Set your GitHub Token
```
export GITHUB_TOKEN="YOUR_GH_TOKEN"
```

### Release
```
goreleaser release
```

## License

[MIT](/LICENSE)
