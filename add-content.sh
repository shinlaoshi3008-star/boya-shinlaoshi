#!/usr/bin/env bash
# ============================================================================
# add-content.sh — Tự động hoá việc thêm bài học / bài kiểm tra mới
#                   vào thư viện Boya Chinese (boya-shinlaoshi)
#
# CÁCH DÙNG (chạy trong Git Bash, đứng tại thư mục gốc repo — nơi có index.html):
#
#   Thêm 1 bài học mới:
#     ./add-content.sh lesson --book 1 --num 2 \
#         --title "你叫什么名字" --pinyin "Nǐ Jiào Shénme Míngzi" \
#         --file /d/Downloads/Bai2.html
#
#   Thêm 1 bài kiểm tra mới (cho đơn vị 5 bài):
#     ./add-content.sh test --book 1 --unit 2 --file /d/Downloads/KT6-10.html
#
#   Xem trạng thái tổng quan (bao nhiêu ô đã điền, bao nhiêu còn trống):
#     ./add-content.sh status
#
#   Thêm cờ --commit "nội dung commit" để tự động git add + commit sau khi xong.
#   Thêm cờ --push để tự động git push luôn (phải đi kèm --commit).
#
# LƯU Ý: Script chỉ ĐIỀN vào các ô (n:1..29 cho Boya I, n:1..25 cho Boya II,
# unit1..unit6 / unit1..unit5) đã có sẵn khung trong index.html. Nếu muốn mở
# rộng vượt quá 29 bài (Boya I) hay 25 bài (Boya II), cần sửa tay index.html
# (thêm dòng mới vào mảng LESSONS/TESTS) trước khi dùng script cho số bài đó.
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

INDEX_FILE="index.html"
BOOK1_TOTAL=29
BOOK2_TOTAL=25

c_red()   { printf '\033[31m%s\033[0m\n' "$1"; }
c_green() { printf '\033[32m%s\033[0m\n' "$1"; }
c_blue()  { printf '\033[34m%s\033[0m\n' "$1"; }

die() { c_red "❌ $1"; exit 1; }

[ -f "$INDEX_FILE" ] || die "Không tìm thấy $INDEX_FILE ở thư mục hiện tại ($SCRIPT_DIR). Hãy chạy script này ngay tại thư mục gốc repo (cùng cấp với index.html)."

usage() {
  cat <<'EOF'
Cách dùng đơn giản nhất — cứ trả lời câu hỏi, không cần nhớ cú pháp:
  ./add-content.sh
  (hoặc gõ rõ: ./add-content.sh wizard)

Cách dùng nâng cao (gõ thẳng 1 dòng lệnh, dành cho ai đã quen):
  ./add-content.sh lesson --book 1|2 --num N --title "..." --pinyin "..." --file duong/dan/BaiN.html [--as TenFile.html] [--commit "msg"] [--push]
  ./add-content.sh test   --book 1|2 --unit N --file duong/dan/KT.html [--as TenFile.html] [--commit "msg"] [--push]
  ./add-content.sh status
  ./add-content.sh help
EOF
}

CMD="${1:-wizard}"
shift || true

BOOK=""; NUM=""; UNIT=""; TITLE=""; PINYIN=""; SRC_FILE=""; AS_NAME=""; COMMIT_MSG=""; DO_PUSH=0

while [ $# -gt 0 ]; do
  case "$1" in
    --book)   BOOK="$2"; shift 2;;
    --num)    NUM="$2"; shift 2;;
    --unit)   UNIT="$2"; shift 2;;
    --title)  TITLE="$2"; shift 2;;
    --pinyin) PINYIN="$2"; shift 2;;
    --file)   SRC_FILE="$2"; shift 2;;
    --as)     AS_NAME="$2"; shift 2;;
    --commit) COMMIT_MSG="$2"; shift 2;;
    --push)   DO_PUSH=1; shift;;
    -h|--help) usage; exit 0;;
    *) die "Không hiểu tham số: $1";;
  esac
done

folder_for_book() {
  case "$1" in
    1) echo "boya1";;
    2) echo "boya2";;
    *) echo "";;
  esac
}

total_for_book() {
  case "$1" in
    1) echo "$BOOK1_TOTAL";;
    2) echo "$BOOK2_TOTAL";;
    *) echo "";;
  esac
}

# Escape dấu nháy đơn để nhét an toàn vào chuỗi JS dạng '...'
js_escape() {
  printf '%s' "$1" | sed "s/'/\\\\'/g"
}

# Escape chuỗi để an toàn khi nhét vào phần thay thế của sed (delimiter dùng là |)
# chỉ cần thoát & và \, KHÔNG thoát / vì / không phải là delimiter ở đây.
sed_escape() {
  printf '%s' "$1" | sed -e 's/[&\]/\\&/g'
}

copy_file_and_fix_link() {
  local src="$1" dest_dir="$2" dest_name="$3"
  mkdir -p "$dest_dir"
  local dest_path="$dest_dir/$dest_name"
  cp "$src" "$dest_path"
  # Sửa nút "Thư viện" thành ../index.html vì file nằm trong thư mục con
  sed -i 's|href="index\.html" class="lib-back"|href="../index.html" class="lib-back"|' "$dest_path"
  sed -i 's|<a href="index\.html">Về thư viện bài học</a>|<a href="../index.html">Về thư viện bài học</a>|' "$dest_path"
  echo "$dest_path"
}

cmd_lesson() {
  [ -n "$BOOK" ] && [ -n "$NUM" ] && [ -n "$TITLE" ] && [ -n "$PINYIN" ] && [ -n "$SRC_FILE" ] \
    || die "Thiếu tham số. Cần: --book --num --title --pinyin --file"

  { [ "$BOOK" = "1" ] || [ "$BOOK" = "2" ]; } || die "--book phải là 1 hoặc 2"
  [ -f "$SRC_FILE" ] || die "Không tìm thấy file nguồn: $SRC_FILE"

  local total
  total="$(total_for_book "$BOOK")"
  if [ "$NUM" -lt 1 ] || [ "$NUM" -gt "$total" ]; then
    die "Boya $BOOK chỉ có $total bài (n:1..$total). Số bài $NUM nằm ngoài phạm vi đã tạo khung sẵn."
  fi

  local folder
  folder="$(folder_for_book "$BOOK")"
  local dest_name="${AS_NAME:-$(basename "$SRC_FILE")}"
  local dest_path
  dest_path="$(copy_file_and_fix_link "$SRC_FILE" "$folder" "$dest_name")"
  local rel_path="$folder/$dest_name"

  local esc_title esc_pinyin esc_path
  esc_title="$(js_escape "$TITLE")"
  esc_pinyin="$(js_escape "$PINYIN")"
  esc_path="$rel_path"

  local is_last=0
  [ "$NUM" -eq "$total" ] && is_last=1

  local tmp
  tmp="$(mktemp)"
  if ! awk -v book="$BOOK" -v num="$NUM" -v title="$esc_title" -v pinyin="$esc_pinyin" -v path="$esc_path" -v is_last="$is_last" '
    BEGIN { in_book = 0; other_book = (book == "1") ? "2" : "1"; done = 0 }
    {
      if ($0 ~ ("book" book ": \\{")) { in_book = 1 }
      else if (in_book && $0 ~ ("book" other_book ": \\{")) { in_book = 0 }
      else if (in_book && $0 ~ /^};/) { in_book = 0 }

      if (in_book && !done && $0 ~ ("\\{n:" num ",")) {
        comma = (is_last == "1") ? "" : ","
        printf("      {n:%s,  title:'"'"'%s'"'"', pinyin:'"'"'%s'"'"', file:'"'"'%s'"'"'}%s\n", num, title, pinyin, path, comma)
        done = 1
        next
      }
      print
    }
    END {
      if (done == 0) { exit 1 }
    }
  ' "$INDEX_FILE" > "$tmp"; then
    rm -f "$tmp"
    die "Không tìm thấy dòng n:$NUM trong khối book$BOOK của LESSONS — kiểm tra lại index.html có bị sửa cấu trúc không."
  fi

  mv "$tmp" "$INDEX_FILE"
  c_green "✅ Đã copy file vào $rel_path"
  c_green "✅ Đã cập nhật Bài $NUM (Boya $BOOK) trong index.html"
}

cmd_test() {
  [ -n "$BOOK" ] && [ -n "$UNIT" ] && [ -n "$SRC_FILE" ] \
    || die "Thiếu tham số. Cần: --book --unit --file"

  { [ "$BOOK" = "1" ] || [ "$BOOK" = "2" ]; } || die "--book phải là 1 hoặc 2"
  [ -f "$SRC_FILE" ] || die "Không tìm thấy file nguồn: $SRC_FILE"

  local key="book${BOOK}-unit${UNIT}"
  grep -q "'${key}':" "$INDEX_FILE" || die "Không tìm thấy khóa '${key}' trong mảng TESTS — kiểm tra lại --book/--unit."

  local folder
  folder="$(folder_for_book "$BOOK")"
  local dest_name="${AS_NAME:-$(basename "$SRC_FILE")}"
  local dest_path
  dest_path="$(copy_file_and_fix_link "$SRC_FILE" "$folder" "$dest_name")"
  local rel_path="$folder/$dest_name"
  local esc_path
  esc_path="$(sed_escape "$rel_path")"

  sed -i "s|'${key}': {file:'[^']*', label:'\\([^']*\\)'}|'${key}': {file:'${esc_path}', label:'\\1'}|" "$INDEX_FILE"

  c_green "✅ Đã copy file vào $rel_path"
  c_green "✅ Đã cập nhật bài kiểm tra đơn vị $UNIT (Boya $BOOK) trong index.html"
}

cmd_status() {
  c_blue "== Boya I (book1) =="
  local b1_filled b1_empty
  b1_filled=$(awk '/book1: \{/{f=1} f&&/book2: \{/{f=0} f' "$INDEX_FILE" | grep -c "file:'[^']" || true)
  b1_empty=$(awk '/book1: \{/{f=1} f&&/book2: \{/{f=0} f' "$INDEX_FILE" | grep -c "file:''" || true)
  echo "  Bài học: $b1_filled đã có link / $((b1_filled+b1_empty)) tổng"
  c_blue "== Boya II (book2) =="
  local b2_filled b2_empty
  b2_filled=$(awk '/book2: \{/{f=1} f&&/^};/{f=0} f' "$INDEX_FILE" | grep -c "file:'[^']" || true)
  b2_empty=$(awk '/book2: \{/{f=1} f&&/^};/{f=0} f' "$INDEX_FILE" | grep -c "file:''" || true)
  echo "  Bài học: $b2_filled đã có link / $((b2_filled+b2_empty)) tổng"
  c_blue "== Bài kiểm tra (TESTS) =="
  grep "'book[12]-unit" "$INDEX_FILE" | sed "s/^ *//" | while IFS= read -r line; do
    if echo "$line" | grep -q "file:''"; then
      echo "  ⏳ $line"
    else
      echo "  ✅ $line"
    fi
  done
}

maybe_git() {
  [ -n "$COMMIT_MSG" ] || { c_blue "ℹ️  Chưa git add/commit — dùng --commit \"nội dung\" nếu muốn script tự làm."; return; }
  git add -A
  git commit -m "$COMMIT_MSG"
  c_green "✅ Đã git commit: $COMMIT_MSG"
  if [ "$DO_PUSH" -eq 1 ]; then
    git push
    c_green "✅ Đã git push"
  else
    c_blue "ℹ️  Chưa push — chạy 'git push' khi sẵn sàng, hoặc thêm --push."
  fi
}

cmd_wizard() {
  echo ""
  c_blue "=== 🧭 Chế độ hỏi-đáp — trả lời từng câu, Enter để tiếp tục ==="
  echo ""

  local kind
  while true; do
    read -r -p "Bạn muốn thêm [1] Bài học  hay  [2] Bài kiểm tra ? Nhập 1 hoặc 2: " kind
    case "$kind" in
      1|2) break;;
      *) c_red "Vui lòng nhập 1 hoặc 2.";;
    esac
  done

  while true; do
    read -r -p "Đây là Boya I hay Boya II ? Nhập 1 hoặc 2: " BOOK
    { [ "$BOOK" = "1" ] || [ "$BOOK" = "2" ]; } && break
    c_red "Vui lòng nhập 1 hoặc 2."
  done

  if [ "$kind" = "1" ]; then
    local total; total="$(total_for_book "$BOOK")"
    while true; do
      read -r -p "Đây là Bài số mấy? (1-$total): " NUM
      if [[ "$NUM" =~ ^[0-9]+$ ]] && [ "$NUM" -ge 1 ] && [ "$NUM" -le "$total" ]; then break; fi
      c_red "Vui lòng nhập một số từ 1 đến $total."
    done
    read -r -p "Tên bài (chữ Hán), ví dụ 你叫什么名字: " TITLE
    read -r -p "Phiên âm pinyin, ví dụ Nǐ Jiào Shénme Míngzi: " PINYIN
  else
    read -r -p "Đây là bài kiểm tra của đơn vị (unit) số mấy? (1, 2, 3...): " UNIT
  fi

  echo ""
  c_blue "Mẹo: có thể kéo-thả file .html từ File Explorer vào cửa sổ Git Bash để tự điền đường dẫn."
  while true; do
    read -r -p "Đường dẫn tới file .html cần thêm: " SRC_FILE
    SRC_FILE="${SRC_FILE%\"}"; SRC_FILE="${SRC_FILE#\"}"   # bỏ dấu " nếu kéo-thả tự thêm vào
    SRC_FILE="${SRC_FILE%\'}"; SRC_FILE="${SRC_FILE#\'}"
    [ -f "$SRC_FILE" ] && break
    c_red "Không tìm thấy file: $SRC_FILE — thử lại (hoặc kéo-thả file vào cửa sổ này)."
  done

  read -r -p "Đổi tên file khi lưu vào thư viện? (Enter để giữ nguyên tên gốc): " AS_NAME

  echo ""
  read -r -p "Tự động git commit luôn không? (y/N): " do_commit
  if [[ "$do_commit" =~ ^[Yy]$ ]]; then
    read -r -p "Nội dung commit (Enter để dùng mặc định): " COMMIT_MSG
    [ -n "$COMMIT_MSG" ] || COMMIT_MSG="Them noi dung moi qua add-content.sh"
    read -r -p "Đẩy (push) lên GitHub luôn không? (y/N): " do_push
    [[ "$do_push" =~ ^[Yy]$ ]] && DO_PUSH=1
  fi

  echo ""
  c_blue "== Xác nhận =="
  if [ "$kind" = "1" ]; then
    echo "  Thêm Bài học — Boya $BOOK, Bài $NUM: \"$TITLE\" ($PINYIN)"
  else
    echo "  Thêm Bài kiểm tra — Boya $BOOK, đơn vị $UNIT"
  fi
  echo "  File nguồn: $SRC_FILE"
  [ -n "$AS_NAME" ] && echo "  Lưu với tên: $AS_NAME"
  [ -n "$COMMIT_MSG" ] && echo "  Sẽ git commit: \"$COMMIT_MSG\"$( [ "$DO_PUSH" -eq 1 ] && echo ' + push' )"
  echo ""
  read -r -p "Xác nhận thực hiện? (Y/n): " confirm
  if [[ "$confirm" =~ ^[Nn]$ ]]; then
    c_blue "Đã huỷ, không có gì thay đổi."
    exit 0
  fi

  echo ""
  if [ "$kind" = "1" ]; then
    cmd_lesson
  else
    cmd_test
  fi
  maybe_git
}

case "$CMD" in
  lesson) cmd_lesson; maybe_git;;
  test)   cmd_test; maybe_git;;
  status) cmd_status;;
  wizard) cmd_wizard;;
  help)   usage;;
  *)      cmd_wizard;;
esac
