# 🔐 Self-Improvement-local-Skill
### 安全、离线、脱敏、无第三方依赖的开发者技能沉淀工具

**No OpenClaw • No Third-Party • No Tracking • No Upload • 100% Local**

[![Security Rating](https://img.shields.io/badge/security-secure-green?style=flat-square)](SECURITY.md)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-bash%2Fzsh-lightgrey?style=flat-square)](README.md)

---

## 🌟 亮点
- **✅ 完全本地运行**，不上传、不同步、不联网
- **✅ 无 OpenClaw / 无第三方工具 / 无后台服务**
- **✅ 自动脱敏：密码、密钥、Token、手机号、邮箱**
- **✅ 权限严格锁定：目录 700 / 文件 600**
- **✅ Git 安全：永远不会被误提交到代码仓库**
- **✅ 企业安全合规**
- **✅ 轻量、干净、可信**

  例如，你只需要在终端输：
skill "Trae AI帮写的批量重命名脚本：for file in *.txt; do mv \"$file\" \"${file%.txt}_new.txt\"; done（作用：把所有txt文件加_new后缀）"
✅ 立刻记录，还自动脱敏（如果代码里有密码 / Token，会自动隐藏）。
Trae AI 写的代码出错了，记下来
比如 AI 生成的代码报「权限错误」，输：
error "Trae AI生成的重命名脚本报错：Permission denied → 解决：加sudo，或检查文件权限（chmod 644 *.txt）"
想看 AI 帮你写过的所有内容，直接输：
skills | grep "Trae AI"  # 只看AI生成的技能
errors | grep "Trae AI"  # 只看AI相关的错误

适配所有 AI 编程工具（Cursor/Copilot/CodeLlama）
用法完全一样，核心就是：
AI 生成的有用代码 → skill "备注+代码"
AI 生成的坑 / 错误 → error "备注+错误+解决方法"
想查的时候 → skills/errors 搜关键词（比如「Copilot」「Cursor」）

补充（懒人技巧）
skill "Trae AI生成XX功能代码：$(pbpaste)"  # Mac用pbpaste，Windows/Git Bash用clipboard，Linux用xclip

---

## 🚀 一键安装
打开终端（Mac 用「终端」App，Linux 用「Terminal」）；
复制粘贴以下命令，回车执行（一键安装）：
```bash
curl -sL https://raw.githubusercontent.com/0LDkim-1/Self-Improvement-local-Skill/main/secure-skill.sh > ~/.my_secure_skill.sh
chmod 600 ~/.my_secure_skill.sh
echo "source ~/.my_secure_skill.sh" >> ~/.bashrc
echo "source ~/.my_secure_skill.sh" >> ~/.zshrc
source ~/.my_secure_skill.sh

AI 工具通用，打开终端，输这行命令（一次启动，全程能用）：
bash <(curl -sL https://raw.githubusercontent.com/0LDkim-1/Self-Improvement-local-Skill/main/secure-skill.sh)

---

## 🖥️ CC Switch 安装方式
1. 下载仓库 ZIP 包：点击仓库右上角「Code」→「Download ZIP」；
2. 解压后，选中 `skill.json` + `secure-skill.sh` 两个文件，重新打包成 ZIP（⚠️ 不要包含外层文件夹）；
3. 打开 CC Switch → Skills 管理 → 上传新打包的 ZIP 包 → 安装成功。
