# Boya 1 · Bài kiểm tra số 1

## Các file
- `github-pages/Boya1_KiemTra01.html`: bài thi học viên, có chế độ xem thử.
- `private-apps-script/Code.gs`: backend riêng của đề 1.
- `private-apps-script/teacher.html`: trang giáo viên.
- `private-apps-script/DapAn_HuongDanCham.md`: hướng dẫn chấm.

## Cấu hình trước khi cho học viên thi
1. Tạo một Google Sheet và một dự án Apps Script riêng cho đề này. Hai đề có thể dùng cùng một Google Sheet (mỗi đề một tab) nhưng cần **hai dự án/deployment riêng** vì mỗi backend có ngân hàng riêng. Không thay Code.gs của đề cũ.
2. Dán Code.gs vào Apps Script. Tạo file HTML tên chính xác **teacher**, dán toàn bộ teacher.html.
3. Project Settings → Script Properties: thêm `SHEET_ID` (ID Google Sheet), `ALLOWED_ORIGIN` (ví dụ https://shinlaoshi3008-star.github.io; chỉ origin, không kèm đường dẫn hoặc / cuối), `EXAM_OPEN` = `true`, `TEACHER_KEY` (mã riêng tối thiểu 16 ký tự, nên 24 ký tự trở lên).
4. Thêm `AUDIO_URL` trỏ đến **một file nghe liên tục** gồm ba phần nghe. PDF không kèm audio: chưa có lời giải nghe xác nhận. Backend chặn ghi danh nếu thiếu URL nghe; giáo viên cần nghe thử URL trên thiết bị học viên trước khi mở thi.
5. Chạy `setup`, cấp quyền. Deploy → New deployment → Web app; execute as Me, truy cập Anyone. Lấy URL kết thúc /exec.
6. Trong HTML học viên, tìm `window.EXAM_CONFIG`, điền `endpoint` bằng URL /exec của **đúng đề**. Không đưa TEACHER_KEY vào HTML. Có thể điền audioUrl để nghe thử trước ghi danh; khi thi thật lấy AUDIO_URL từ backend.
7. Đưa **chỉ HTML học viên** vào GitHub Pages. Không đưa thư mục private-apps-script lên repo công khai.
8. Mở trang giáo viên tại `URL_DEPLOYMENT/exec?page=teacher`, nhập mã. Theo dõi học sinh, lọc lớp, xem ma trận, câu cần ôn; bấm Xem bài / Chấm để nhập điểm phần tự viết/nghe, sau đó Lưu điểm. Mã giáo viên chỉ giữ trong bộ nhớ phiên, đăng xuất xóa mã và dữ liệu hiển thị. Không có chức năng xóa bài nộp.
9. Học viên bấm Cập nhật kết quả để nhận điểm giáo viên chấm. Câu chờ chấm không bị tính là sai; điểm chưa hoàn tất có nhãn tạm tính.

## Nối vào index hiện tại
Thêm link riêng đến `Boya1_KiemTra01.html` ở đúng thư mục bạn đặt file; giữ mọi link bài thi cũ. Chưa sửa index của bạn vì không có file index trong yêu cầu này.

## Kiểm tra thật trước khi phát đề
Tạo lượt thử, điền bài, nộp; đối chiếu tab BOYA1-TEST-01 trong Sheet và trang teacher. Thử mã giáo viên sai, bộ lọc, CSV, chấm tay, học viên cập nhật điểm. Đã kiểm tra bằng backend mô phỏng và trình duyệt; **chưa kết nối/kiểm tra Google Sheets thật**, vì chưa có URL triển khai.

## Khôi phục và lưu bài
Bản nháp gắn mã đề và mã lượt, giữ mốc bắt đầu khi tải lại/đổi giao diện; nộp lặp trả bản đã lưu. Khi mất mạng, bài làm khóa trên thiết bị, chưa mở đáp án cho đến khi nhận xác nhận máy chủ; tải JSON bản sao rồi gửi lại. JSON không chứa token. Bản sao không tự nhập vào Sheet.

## Khác biệt bản giấy
Giữ câu hỏi, trọng số và thời gian nguồn. Không chuyển phần viết thành trắc nghiệm. Đếm nét nhập số; phần thứ tự nét viết bằng tay/chuột trên ô vẽ và lưu thứ tự từng nét. Phần điền thanh ở câu 16–20 nhập lại cả câu pinyin có thanh điệu; câu nghe không tự chấm khi chưa có audio nguồn.
