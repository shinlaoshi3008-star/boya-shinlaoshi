# Boya Chinese · Thư viện bài học

Trang tổng hợp các bài học tương tác Boya Chinese I & II.

## Cấu trúc
- `index.html` — trang tổng hợp (trang chủ), chứa mảng `LESSONS` để gắn link từng bài
- `Bai1.html`, `Bai5.html`, ... — từng bài học riêng lẻ

## Thêm bài học mới
1. Đặt file bài học mới (ví dụ `Bai2.html`) vào cùng thư mục với `index.html`
2. Mở `index.html`, tìm mảng `LESSONS` trong thẻ `<script>`
3. Điền `title`, `pinyin`, `file` cho bài tương ứng
4. Commit & push — GitHub Pages sẽ tự cập nhật sau ~1 phút

## Deploy trên GitHub Pages
Settings → Pages → Source: chọn nhánh `main`, thư mục `/ (root)` → Save
