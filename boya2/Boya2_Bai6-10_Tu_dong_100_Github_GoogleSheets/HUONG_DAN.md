# Hệ thống mới: Boya 2 · Bài 6–10 · Chấm tự động 100%

24 câu, 30 phút, 100 điểm. Giữ nội dung/ngữ pháp của PDF. Phần hoàn thành câu và sửa câu sai chuyển sang chọn đáp án để chấm khách quan; không còn viết tự do. Cả 4 phần mở ngay, dùng chung đồng hồ. Không có nghe/audio trong đề PDF này.

## 1. Tạo Google Sheet mới

- Tạo một Google Sheet, đặt tên “Boya 2 – Kiểm tra tự động bài 6–10”.
- Lấy ID trong URL, giữa `/d/` và `/edit`.
- Trong Sheet, chọn Tiện ích mở rộng → Apps Script. Đây là dự án mới, không sửa dự án nhận bài hôm trước.
- Thay mã mặc định của Code.gs bằng toàn bộ `private-apps-script/Code.gs` trong gói này. Lưu.

## 2. Cấu hình dự án mới

Vào Cài đặt dự án (bánh răng) → Thuộc tính tập lệnh → Thêm thuộc tính:

| Thuộc tính | Giá trị |
|---|---|
| SHEET_ID | ID của Google Sheet mới |
| ALLOWED_ORIGIN | https://shinlaoshi3008-star.github.io |
| EXAM_OPEN | true |

ALLOWED_ORIGIN không chứa `/boya-shinlaoshi/` và không có dấu `/` cuối. Có thể đặt múi giờ dự án thành GMT+07:00 để log hiển thị theo giờ Việt Nam.

Trở về Trình chỉnh sửa → chọn hàm `setup` → Chạy → cấp quyền cho script. Trong Sheet sẽ có tab `KetQua_TuDong`.

## 3. Triển khai Apps Script

- Triển khai → Bản triển khai mới.
- Chọn loại “Ứng dụng web”.
- Thực thi dưới tư cách: “Tôi”.
- Người có quyền truy cập: “Bất kỳ ai”.
- Bấm Triển khai, cấp quyền nếu cần, sao chép URL kết thúc bằng `/exec`.

## 4. Điền URL vào HTML

- Mở `github-pages/Boya2_Bai6-10_Kiem_tra_tu_dong.html` bằng VS Code hoặc Notepad.
- Tìm chính xác `endpoint:''`.
- Thay bằng `endpoint:'URL_EXEC_VỪA_SAO_CHÉP'`. Giữ nguyên dấu nháy; dùng URL thật của bản triển khai mới.
- Lưu file. Không thay mã đề `BOYA2-6-10-AUTO-02`.

HTML mặc định để trống endpoint nhằm tránh gửi nhầm sang hệ thống cũ. Khi chưa điền, thầy vẫn mở “Xem thử giao diện”, nhưng không gửi bài hoặc chấm điểm.

## 5. Đưa lên GitHub

- Chỉ upload file HTML trên vào thư mục `boya2` của repository `boya-shinlaoshi`.
- Không upload Code.gs, đáp án hoặc toàn bộ ZIP lên thư mục công khai.
- Trong index tổng, thêm liên kết `boya2/Boya2_Bai6-10_Kiem_tra_tu_dong.html`, nhãn “Kiểm tra bài 6–10 · Tự động 100%”.
- Sau khi Pages cập nhật, mở:
  https://shinlaoshi3008-star.github.io/boya-shinlaoshi/boya2/Boya2_Bai6-10_Kiem_tra_tu_dong.html

## 6. Kiểm tra trước buổi thi

- Đăng ký một lượt bằng tên “TEST”, lớp “TEST”.
- Chọn đáp án ở cả 4 tab, nộp và kiểm tra dòng “Đã nhận xác nhận”.
- Google Sheet có tên/lớp, thời gian, 4 điểm phần, tổng /100 và đáp án của 24 câu.
- Không cần giáo viên nhập điểm. Điểm được tính ở Apps Script, không lấy điểm do trình duyệt gửi lên.
- Dữ liệu của đề hôm trước không bị ảnh hưởng vì dùng dự án/Sheet/URL riêng.

## Thang điểm và log

I: 8×2,5=20. II: 5×6=30. III: 5×4=20. IV: 6×5=30. Tổng 100.

Cột H–K: bốn phần; L: tổng /100; M: trạng thái; N: nộp trễ; O: rời tab. R–AO: đáp án câu 1–24, lưu chỉ số lựa chọn từ 0 (A=0, B=1…). Lượt thi và token tránh ghi trùng khi gửi lại.

Bỏ trống = 0 điểm. Hết 30 phút tự nộp. Rời tab chỉ ghi log, không tự trừ điểm. Bài gửi muộn do mạng vẫn được nhận và có cờ nộp trễ để giáo viên xem xét. Khi mạng lỗi, giữ trang, tải bản sao bài làm và bấm “Gửi lại bài làm”. Chỉ xác nhận từ máy chủ mới chứng minh đã lưu vào Sheet.

Đăng ký bằng tên/lớp không xác minh danh tính tài khoản. “Xem thử” không tạo kết quả thi thật. Mỗi thiết bị giữ một lượt đang lưu; dùng cửa sổ riêng cho lượt TEST nếu cần tránh lẫn với lượt học viên.
