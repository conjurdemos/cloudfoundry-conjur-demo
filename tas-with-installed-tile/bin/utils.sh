#!/usr/bin/env bash

set -euo pipefail

announce() {
  echo "++++++++++++++++++++++++++++++++++++++"
  echo ""
  echo "$@"
  echo ""
  echo "++++++++++++++++++++++++++++++++++++++"
}

check_env_var() {
  var_name=$1

  if [[ -z "${!var_name:-}" ]]; then
    echo "You must set $1 before running these scripts."
    exit 1
  fi
}
