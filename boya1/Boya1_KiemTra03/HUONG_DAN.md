# Bài kiểm tra số 3 · Boya 1 · Ôn tập bài 6–10

30 phút · 30 câu · 5 phần · 100 điểm. Pinyin 10 điểm và chọn vị trí 10 điểm tự động; đặt câu hỏi 20, hoàn thành hội thoại 20, dịch câu 40 do giáo viên chấm. Không có nghe; không cần AUDIO_URL. Giữ tự viết theo đề giấy. Trang đáp án có lỗi trọng số; bộ này dùng trọng số trên trang đề để tổng đúng 100. Chỉnh lỗi chữ/thiếu động từ được ghi trong đáp án riêng.

## Triển khai riêng cho đề 03
1. Tạo Google Sheet và dự án Apps Script riêng cho đề 03. Có thể dùng Sheet đang có (mỗi đề một tab), nhưng **không thay Code.gs hoặc deployment đề 01/02**.
2. Dán private-apps-script/Code.gs vào Code.gs; tạo HTML tên **teacher**, dán teacher.html. Thêm Script Properties: SHEET_ID (ID Sheet), ALLOWED_ORIGIN=https://shinlaoshi3008-star.github.io, EXAM_OPEN=true, TEACHER_KEY (ít nhất 16 ký tự, nên 24 trở lên). Không đưa mã giáo viên vào HTML học viên. Không cần AUDIO_URL.
3. Chạy setup, cấp quyền. Deploy → New deployment → Web app → Execute as Me → Anyone; sao chép URL kết thúc /exec.
4. Trong github-pages/Boya1_KiemTra03.html, tìm window.EXAM_CONFIG, điền endpoint bằng URL /exec vừa lấy. Endpoint hiện để trống vì chưa được cung cấp; vẫn mở Xem thử giao diện ngoại tuyến. Font và ảnh nhúng sẵn.
5. Chỉ đưa HTML học viên vào thư mục đề 03 trên GitHub; không đưa private-apps-script/teacher.html/đáp án/Code.gs lên repo công khai.
6. Mở URL_DEPLOYMENT/exec?page=teacher, nhập mã giáo viên. Có lọc lớp/tìm tên/ma trận/câu cần ôn/xem bài/CSV và chấm 15 câu tự viết. Mã chỉ giữ trong bộ nhớ phiên; đăng xuất xóa dữ liệu. Sau Lưu điểm, học viên chọn Cập nhật kết quả để nhận tổng cuối cùng. Câu chờ chấm không tính là sai.
7. Thêm liên kết riêng đến Boya1_KiemTra03.html vào index hiện tại; giữ nguyên link đề 01/02. Chưa sửa index vì không có file index trong yêu cầu.

## Cách làm và lưu bài
Pinyin có đủ 10 từ trên một trang, nhận dấu hoặc số thanh; thanh nhẹ không dấu/5/0, 儿 hóa hui4r/huir4. Mỗi từ đúng 1 điểm. Phần đặt câu hỏi có gạch chân và nền nhạt đúng từ cần hỏi. Ba phần tự viết nhập bằng bàn phím. Chọn vị trí theo A–D.

Timer dùng chung 30 phút; chuyển phần/layout không đặt lại thời gian. Nháp lưu theo mã đề và lượt thi. Hết giờ/nộp bài sẽ khóa; mất mạng giữ bản sao để gửi lại. Nộp lặp trả bản đã lưu, không ghi đè. JSON sao lưu không chứa token. Chỉ mở lời giải sau khi máy chủ xác nhận lưu. Điểm tự động ghi tạm tính khi còn bài tự viết chờ chấm.

## Kiểm tra trước khi dùng
Đã kiểm tra backend mô phỏng và trình duyệt, không coi là đã gửi Google Sheets thật. Sau triển khai tạo một lượt lớp THU_NGHIEM để kiểm tra ghi danh/nộp/Sheet/teacher/chấm tay/cập nhật kết quả trước khi cho học viên thi.
