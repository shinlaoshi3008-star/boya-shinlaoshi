# Đề 4 · Ôn tập bài 11–15
20 câu, 4 phần, 30 phút, 100 điểm. Toàn bộ câu tự viết do giáo viên chấm. Không có phần nghe; không cần AUDIO_URL.

1. Tạo Apps Script riêng cho đề này, dán Code.gs và tạo file HTML tên teacher từ teacher.html. Không thay deployment các đề cũ.
2. Script Properties: SHEET_ID, ALLOWED_ORIGIN (origin trang học viên, ví dụ https://shinlaoshi3008-star.github.io), EXAM_OPEN=true, TEACHER_KEY (ít nhất 16 ký tự, nên 24). Chạy setup và cấp quyền.
3. Deploy web app: Execute as Me, Anyone. Sao chép URL /exec vào endpoint trong window.EXAM_CONFIG của HTML học viên. Endpoint hiện để trống; có thể mở Xem thử giao diện ngoại tuyến.
4. Chỉ đưa github-pages/Boya1_KiemTra04.html lên trang học viên. Giữ private-apps-script và đáp án riêng cho giáo viên.
5. Mở URL_DEPLOYMENT/exec?page=teacher, nhập TEACHER_KEY, chọn học viên, chấm từng câu và lưu điểm. Điểm được ghi vào Chấm tay JSON của đúng dòng bài nộp trong Sheet; tổng được tính lại từ dữ liệu đã lưu. Chấm lại cập nhật dòng cũ. Giáo viên có thể xuất CSV gồm tổng điểm từ teacher.html; backend không tạo cột tổng điểm riêng.
6. Học viên chọn Cập nhật kết quả để xem tổng mới. Câu chờ chấm không tính là sai; tổng trước khi chấm là tạm tính.

Nháp lưu theo mã đề/lượt thi. Timer 30 phút không khởi động lại khi chuyển phần. Nộp lặp không ghi đè bài đã lưu; mất mạng giữ bản sao để gửi lại. Chỉ mở tham khảo sau khi máy chủ xác nhận nộp.

Các lỗi nguồn và đáp án thay thế được ghi trong DapAn_HuongDanCham.md. Đã kiểm tra mô phỏng backend và giao diện; chưa kết nối Google Sheet thật vì chưa có deployment. Sau triển khai thử một lượt lớp THU_NGHIEM, chấm và cập nhật kết quả trước khi mở thi.
