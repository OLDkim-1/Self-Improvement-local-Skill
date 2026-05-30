SKILL_DIR="$HOME/.my_secure_skills"

__init_secure() {
  mkdir -m 700 -p "$SKILL_DIR"
  touch "$SKILL_DIR/skills.md" "$SKILL_DIR/errors.md" "$SKILL_DIR/audit.log"
  chmod 600 "$SKILL_DIR"/*
  echo -e "*\n!.gitignore\n!*.md" > "$SKILL_DIR/.gitignore"
}

__sanitize() {
  input="$1"
  echo "$input" | sed -E \
    -e 's/[A-Za-z0-9]{15,60}/[REDACTED_KEY]/g' \
    -e 's/password[^=]*=[^ ]*/password=[REDACTED]/gi' \
    -e 's/pass[^=]*=[^ ]*/pass=[REDACTED]/gi' \
    -e 's/secret[^=]*=[^ ]*/secret=[REDACTED]/gi' \
    -e 's/token[^=]*=[^ ]*/token=[REDACTED]/gi' \
    -e 's/AWS_[A-Z0-9_]*=[^ ]*/[REDACTED_AWS]/g' \
    -e 's/[0-9]{11}/[REDACTED_PHONE]/g' \
    -e 's/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/[REDACTED_EMAIL]/g'
}

skill() {
  __init_secure
  local content="$*"
  local safe="$(__sanitize "$content")"
  local time=$(date '+%Y-%m-%d %H:%M:%S')
  echo -e "\n## $time\n$safe" >> "$SKILL_DIR/skills.md"
  echo "✅ Skill recorded (sanitized)"
}

error() {
  __init_secure
  local content="$*"
  local safe="$(__sanitize "$content")"
  local time=$(date '+%Y-%m-%d %H:%M:%S')
  echo -e "\n## $time\n$safe" >> "$SKILL_DIR/errors.md"
  echo "✅ Error recorded (sanitized)"
}

skills() { cat "$SKILL_DIR/skills.md"; }
errors() { cat "$SKILL_DIR/errors.md"; }

skill_audit() {
  echo "🔍 Security Audit:"
  ls -ld "$SKILL_DIR"
  ls -l "$SKILL_DIR"
}

skill_reset() {
  read -p "⚠️ Delete all data? (y/n) " ans
  [ "$ans" = "y" ] && rm -rf "$SKILL_DIR" && echo "✅ All data deleted."
}
