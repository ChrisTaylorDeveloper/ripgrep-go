#!/usr/bin/env bash

# Ripgrep Go
#
# Usage:
#   rgg <pattern> [--context=<lc>]
#   rgg -h | --help
#   rgg --version
#
# Options:
#   -c --context=<lc>  Lines of context before and after match [default: 0].
#   -h --help     Show this help message.
#   -v --version  Show version information.

VERSION='Ripgrep Go 1.0.0'
# shellcheck disable=SC1091
source docopts.sh
usage=$(docopt_get_help_string "$0")
eval "$(docopts -A ARGS -V "$VERSION" -h "$usage" : "$@")"
# docopt_print_ARGS

search_dir="$PWD"
pattern="${ARGS['<pattern>']}"
echo Searching "$search_dir" for "$pattern"
echo

rg \
  \
  `# Remove whitespace from beginning of lines` \
  --trim \
  `# DO search in hidden` \
  --hidden \
  `# DO search in ignored` \
  `# --no-ignore` \
  `# Print only paths containing matches` \
  `# --files-with-matches` \
  `# Print only paths without matches` \
  `# --files-without-match` \
  `# Print path above batch of matches` \
  --heading \
  `# Case insensitive if pattern all lowercase` \
  --smart-case \
  `# Sort in ascending order, by file path` \
  --sort=path \
  --color=always \
  `# --no-line-number` \
  `# Include or exclude files and dirs that match the given glob.` \
  --glob=!.git/* \
  --glob=!vendor/* \
  --before-context="${ARGS['--context']}" \
  --after-context="${ARGS['--context']}" \
  \
  "$pattern" \
  "$search_dir"
