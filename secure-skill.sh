#!/bin/bash
SKILL_DIR="$HOME/.my_secure_skills"

# 初始化函数
__init_secure() {
  mkdir -m 700 -p "$SKILL_DIR"
  touch "$SKILL_DIR/skills.md" "$SKILL_DIR/errors.md" "$SKILL_DIR/audit.log"
  chmod 600 "$SKILL_DIR"/*
  echo -e "*\n!.gitignore\n!*.md" > "$SKILL_DIR/.gitignore"
}

# 脱敏函数
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

# 适配 CC Switch + 终端双模式
case "$1" in
  # CC Switch 安装命令
  install)
    __init_secure
    echo "✅ 安全本地技能工具安装成功（支持 CC Switch/终端）"
    ;;
  # 记录技能（兼容 CC Switch/终端）
  skill)
    __init_secure
    shift
    content="$*"
    safe="$(__sanitize "$content")"
    time=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\n## $time\n$safe" >> "$SKILL_DIR/skills.md"
    echo "✅ 技能已记录（脱敏）"
    ;;
  # 记录错误（兼容 CC Switch/终端）
  error)
    __init_secure
    shift
    content="$*"
    safe="$(__sanitize "$content")"
    time=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\n## $time\n$safe" >> "$SKILL_DIR/errors.md"
    echo "✅ 错误已记录（脱敏）"
    ;;
  # 查看技能
  skills)
    cat "$SKILL_DIR/skills.md"
    ;;
  # 查看错误
  errors)
    cat "$SKILL_DIR/errors.md"
    ;;
  # 安全审计
  audit)
    echo "🔍 安全审计："
    ls -ld "$SKILL_DIR"
    ls -l "$SKILL_DIR"
    ;;
  # 清空数据
  reset)
    read -p "⚠️ 确认删除所有记录？(y/n) " ans
    [ "$ans" = "y" ] && rm -rf "$SKILL_DIR" && echo "✅ 所有数据已清除"
    ;;
  # 无参数时显示帮助（终端模式）
  *)
    # 终端直接运行时的原有逻辑
    if [ $# -eq 0 ]; then
      __init_secure
      echo "⚠️ 请指定命令：skill <内容>/error <内容>/skills/errors/audit/reset"
    else
      # 兼容旧版终端用法（直接传内容）
      content="$*"
      safe="$(__sanitize "$content")"
      time=$(date '+%Y-%m-%d %H:%M:%S')
      echo -e "\n## $time\n$safe" >> "$SKILL_DIR/skills.md"
      echo "✅ 技能已记录（脱敏）"
    fi
    ;;
esac
