# fxerkan/homebrew-tap

Homebrew tap for [`concealer`](https://github.com/fxerkan/concealer) — a
local-only, single-file secret manager over SOPS + age (CLI · Web UI · MCP).

## Install

```sh
brew install fxerkan/tap/concealer
```

or:

```sh
brew tap fxerkan/tap
brew install concealer
```

## Getting started

```sh
concealer init          # master password + recovery codes + CLI token
export CONCEALER_TOKEN=… # run the line printed by init
concealer web 8787      # http://localhost:8787
concealer help
```
