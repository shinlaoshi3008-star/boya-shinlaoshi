# Bài kiểm tra Boya 1 số 01 · V2

## Cập nhật hệ thống hiện tại
1. Thay HTML học viên bằng `github-pages/Boya1_KiemTra01.html` vào đúng đường dẫn GitHub hiện tại. Endpoint hiện tại đã được giữ sẵn; audio xem thử đã điền. GIF và font được nhúng nên HTML vẫn hiển thị khi mở ngoại tuyến. Thư mục GIF_net_chu chứa 5 GIF riêng để sử dụng thêm.
2. Trong **dự án Apps Script đang nhận bài kiểm tra 01**, thay nội dung Code.gs bằng file trong private-apps-script. Thay nội dung file HTML tên **teacher** bằng teacher.html cùng thư mục.
3. Giữ các Script Properties: SHEET_ID, ALLOWED_ORIGIN, EXAM_OPEN, TEACHER_KEY (ít nhất 16 ký tự), AUDIO_URL. AUDIO_URL lấy từ backend khi thi thật; không cần nhập lại nếu đã cấu hình đúng. Không đưa mã giáo viên vào HTML học viên.
4. Chọn Deploy → Manage deployments → Edit (bút chì) → Version: New version → Deploy. Cập nhật deployment hiện tại để **giữ nguyên URL /exec**, không cần tạo URL mới.
5. Mở `/exec?page=teacher`, chọn Bản mới V2 hoặc Bản cũ. Bản mới ghi vào tab **BOYA1-TEST-01-V2**; backend vẫn phục vụ BOYA1-TEST-01 và giữ toàn bộ kết quả/chấm tay cũ. Không đổi tên hoặc xóa tab cũ.
6. Chỉ đưa HTML học viên lên GitHub; không công khai Code.gs, teacher.html hoặc đáp án. Không thay backend của đề kiểm tra 02.

## Cách làm
- Câu 1–5: hai ô thanh mẫu; 6–10: hai ô vận mẫu + số thanh (ao4); 11–15: cặp thanh (2-3). Hướng dẫn xuất hiện ở đầu mỗi nhóm.
- Câu 16–20: một chữ Hán mỗi ô trên, nhập pinyin vào ô song song ngay dưới; mỗi cặp ô luôn giữ cùng nhau khi xuống dòng trên điện thoại.
- Câu 26–30: GIF đếm nét, nhập số. Câu 31–35: năm ô có chữ mờ; tô đủ nét, theo đúng thứ tự/hướng; xóa từng nét hoặc xóa hết được.
- Chấm trên máy chủ sau khi nộp; đáp án không nằm trong trang học viên. Có điểm từng ô và lời giải sau khi máy chủ xác nhận. Không báo đúng/sai trước khi nộp.
- Tô chữ đối chiếu đường mẫu có dung sai, **không nhận dạng chữ viết tự do**. Mỗi chữ khớp nhận 4 điểm; chưa khớp 0. Tiêu chí chi tiết trong hướng dẫn chấm riêng. Có thể xem và phát lại từng nét trên trang giáo viên.
- 30 phút dùng chung; lưu nháp trên thiết bị, nộp lặp không tạo kết quả trùng; mất mạng giữ bài đã khóa để gửi lại. JSON sao lưu không chứa token.

## Kiểm tra trước khi phát đề
Đã kiểm tra chấm bằng backend mô phỏng và trình duyệt, gồm giao diện điện thoại. Chưa cập nhật trực tiếp Apps Script/GitHub hoặc gửi vào Google Sheets thật. Sau khi cập nhật deployment, nên tạo một lượt thử, nghe audio, tô nét và nộp rồi kiểm tra kết quả ở teacher. Dùng tên lớp THU_NGHIEM để dễ lọc.
