# Boya Chinese · Thư viện bài học

Trang tổng hợp các bài học tương tác Boya Chinese I & II.
- **Boya I (博雅汉语 I)**: 29 bài, chia 6 đơn vị (5 bài/đơn vị, đơn vị cuối 4 bài: 26–29), mỗi đơn vị có 1 bài kiểm tra
- **Boya II (博雅汉语 II)**: 25 bài, chia 5 đơn vị (5 bài/đơn vị), mỗi đơn vị có 1 bài kiểm tra

## Cấu trúc thư mục
```
index.html                 ← trang tổng hợp (trang chủ)
google-apps-script.gs.txt  ← code cầu nối lưu điểm vào Google Sheet
.nojekyll
boya1/                      ← toàn bộ bài học & kiểm tra của Boya sơ cấp I
  Bai1.html
  Bai5.html
  KT1-5.html
boya2/                      ← toàn bộ bài học & kiểm tra của Boya sơ cấp II
  KT2-Bai1-5.html
```
⚠️ Vì `index.html` nằm ở thư mục gốc còn các file bài học nằm trong `boya1/` và `boya2/`,
mọi bài học/kiểm tra MỚI thêm vào sau này đều phải:
1. Đặt file `.html` vào đúng thư mục con (`boya1/` cho Boya I, `boya2/` cho Boya II)
2. Trong file đó, nút "Thư viện" phải trỏ về `../index.html` (lùi ra 1 cấp), không phải `index.html`
3. Trong `index.html`, khai báo đường dẫn kèm tên thư mục con, ví dụ: `file:'boya1/Bai2.html'`

## Tính năng trong mỗi bài học
- Nút "Thư viện" (góc trên trái) — quay lại trang tổng hợp `index.html`
- Nút hình vuông mũi tên (góc trên phải) — bật chế độ Trình chiếu toàn màn hình (Fullscreen), phù hợp khi xuất ra TV/máy chiếu. Bấm nút tròn tối góc phải hoặc phím Esc để thoát.

## Bài kiểm tra
- `boya1/KT1-5.html` — trắc nghiệm, tính giờ, chấm điểm ngay, lưu Google Sheet
- `boya2/KT2-Bai1-5.html` — điền từ / viết lại câu / sắp xếp câu / đọc hiểu, có tự chấm đối chiếu đáp án mẫu, đếm ngược 30 phút, lưu Google Sheet

### Cách cấu hình lưu điểm vào Google Sheet
1. Mở file `google-apps-script.gs.txt`, làm theo 8 bước hướng dẫn ngay đầu file
2. Mở từng file kiểm tra, tìm dòng `const SHEET_WEBHOOK_URL = '';`, dán URL Web App vào giữa 2 dấu nháy
3. Lưu file, upload/push lại lên GitHub

## Thêm bài học hoặc bài kiểm tra mới
1. Đặt file `.html` mới vào đúng thư mục con (`boya1/` hoặc `boya2/`)
2. Mở `index.html`:
   - Thêm bài học: tìm mảng `LESSONS`, điền `title`, `pinyin`, `file` cho đúng số bài (`n`)
   - Thêm bài kiểm tra: tìm mảng `TESTS`, điền `file` cho đúng khóa đơn vị (`book1-unit2`, `book2-unit3`...)
3. Commit & push — GitHub Pages tự cập nhật sau ~1 phút

## Deploy trên GitHub Pages
Settings → Pages → Source: chọn nhánh `main`, thư mục `/ (root)` → Save
