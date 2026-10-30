#!/usr/bin/env bash

usage() {
  echo "usage: update-pins [brew|vicinae]..." >&2
  exit 2
}

FLAKE_ROOT="${FLAKE:-$(git rev-parse --show-toplevel)}"

BREW_FILE="$FLAKE_ROOT/modules/darwin/brew/default.nix"

# shellcheck disable=SC2329
prefetch_github() {
  nurl -H "https://github.com/$1/$2" "$3"
}

# shellcheck disable=SC2329
is_sri() {
  [[ $1 =~ ^sha256-[A-Za-z0-9+/]{43}=$ ]]
}

# shellcheck disable=SC2329
update_brew() {
  local tag current hash repo rev rc=0

  tag=$(gh api "repos/homebrew/brew/releases/latest" --jq .tag_name) || {
    echo "brew: failed to query the latest release" >&2
    return 1
  }
  [[ $tag =~ ^[0-9A-Za-z._-]+$ ]] || {
    echo "brew: unexpected tag '$tag'" >&2
    return 1
  }
  current=$(sed -n 's/.*tag = "\(.*\)";.*/\1/p' "$BREW_FILE") || {
    echo "brew: failed to read current pin" >&2
    return 1
  }
  if [ "$tag" = "$current" ]; then
    echo "brew: up to date ($tag)"
  else
    hash=$(prefetch_github homebrew brew "$tag") || {
      echo "brew: prefetch failed for tag $tag" >&2
      return 1
    }
    is_sri "$hash" || {
      echo "brew: unexpected hash '$hash'" >&2
      return 1
    }
    sed -i "/repo = \"brew\";/,/}/ {
      s|tag = \".*\";|tag = \"$tag\";|
      s|hash = \".*\";|hash = \"$hash\";|
    }" "$BREW_FILE" || {
      echo "brew: failed to edit $BREW_FILE" >&2
      return 1
    }
    echo "brew: $current -> $tag"
  fi

  for repo in homebrew-core homebrew-cask; do
    rev=$(gh api "repos/homebrew/$repo/commits/HEAD" --jq .sha) || {
      echo "$repo: failed to query HEAD" >&2
      rc=1
      continue
    }
    [[ $rev =~ ^[0-9a-f]{40}$ ]] || {
      echo "$repo: unexpected rev '$rev'" >&2
      rc=1
      continue
    }
    current=$(sed -n "/repo = \"$repo\";/,/}/ s/.*rev = \"\(.*\)\";.*/\1/p" "$BREW_FILE") || {
      echo "$repo: failed to read current pin" >&2
      rc=1
      continue
    }
    if [ "$rev" = "$current" ]; then
      echo "$repo: up to date (${rev:0:12})"
      continue
    fi
    hash=$(prefetch_github homebrew "$repo" "$rev") || {
      echo "$repo: prefetch failed for ${rev:0:12}" >&2
      rc=1
      continue
    }
    is_sri "$hash" || {
      echo "$repo: unexpected hash '$hash'" >&2
      rc=1
      continue
    }
    sed -i "/repo = \"$repo\";/,/}/ {
      s|rev = \".*\";|rev = \"$rev\";|
      s|hash = \".*\";|hash = \"$hash\";|
    }" "$BREW_FILE" || {
      echo "$repo: failed to edit $BREW_FILE" >&2
      rc=1
      continue
    }
    echo "$repo: ${current:0:12} -> ${rev:0:12}"
  done

  return "$rc"
}

failed=0

run_target() {
  if ! "update_$1"; then
    echo "$1: FAILED" >&2
    failed=1
  fi
}

main() {
  local -a targets=("$@")
  if [ ${#targets[@]} -eq 0 ]; then
    targets=(brew vicinae)
  fi

  local t
  for t in "${targets[@]}"; do
    case "$t" in
    brew | vicinae) run_target "$t" ;;
    *) usage ;;
    esac
  done

  exit "$failed"
}

main "$@"
