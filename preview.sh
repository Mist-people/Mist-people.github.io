#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
if [ -x /opt/homebrew/opt/ruby/bin/ruby ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
elif [ -x /opt/homebrew/Library/Homebrew/vendor/portable-ruby/current/bin/ruby ]; then
  export PATH="/opt/homebrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH"
fi
mkdir -p logs
printf 'INFO Starting local Jekyll preview at http://127.0.0.1:4000\n' | tee -a logs/operations.log
bundle exec jekyll serve --host 127.0.0.1 --port 4000 --trace 2>&1 | while IFS= read -r line; do printf "INFO %s\n" "$line"; done | tee -a logs/preview.log
