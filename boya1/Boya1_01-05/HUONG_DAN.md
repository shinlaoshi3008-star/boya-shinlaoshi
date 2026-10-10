# Bài kiểm tra số 2 · Boya 1 · Ôn tập bài 1–5 · V2

## Nội dung mới
Giữ 35 câu, 5 phần, 30 phút, 100 điểm theo PDF có đáp án. Pinyin 20 điểm chấm tự động; điền từ 10, chọn đáp án 10, chọn vị trí 20 chấm tự động. Hoàn thành câu 40 điểm giữ tự viết, giáo viên chấm theo đáp án mẫu và rubric. Bài thi không có nghe, không cần AUDIO_URL. Pinyin chấp nhận dấu hoặc số thanh, viết liền/cách âm tiết, thanh nhẹ 5/0/không dấu. Toàn bộ 10 từ pinyin cùng trang, 5 câu điền từ cùng trang và chọn từ ngay trong chỗ trống.

## Cập nhật đúng đề 02
1. Thay HTML học viên hiện tại bằng github-pages/Boya1_KiemTra02.html. Trong window.EXAM_CONFIG, điền endpoint bằng **URL /exec của Apps Script đang phục vụ đề 02** nếu còn trống. Chưa đọc được endpoint đề 02 từ trang hiện tại nên file để trống và vẫn có Xem thử; không dùng URL của đề 01.
2. Trong dự án Apps Script của đề **02**, thay Code.gs bằng private-apps-script/Code.gs. Thay nội dung file HTML tên **teacher** bằng teacher.html. Không thay backend của đề 01.
3. Giữ các Script Properties SHEET_ID, ALLOWED_ORIGIN, EXAM_OPEN=true, TEACHER_KEY (ít nhất 16 ký tự). ALLOWED_ORIGIN chỉ là https://shinlaoshi3008-star.github.io, không kèm đường dẫn hoặc dấu / cuối. Không cần AUDIO_URL cho đề này.
4. Deploy → Manage deployments → Edit → Version: New version → Deploy; giữ URL /exec hiện tại. Nếu chưa có Apps Script đề 02, tạo dự án riêng, tạo teacher, thêm các properties, chạy setup, cấp quyền và Deploy Web app (Execute as Me, Anyone). Dán URL /exec mới vào HTML.
5. Backend mới giữ hỗ trợ đề cũ BOYA1-TEST-02 và tab cũ. Bản mới dùng tab BOYA1-TEST-02-V2; không xóa/đổi tên tab cũ. Trang teacher cho chọn Bản mới/Bản cũ. Lượt cũ vẫn giữ cách chấm cũ, không tự thay điểm đã chấm.
6. Chỉ đưa HTML học viên lên GitHub. Giữ Code.gs, teacher.html và đáp án ở ngoài repo công khai. Giữ index hiện tại/link đề cũ; nếu HTML ở cùng đường dẫn thì không cần sửa index.
7. Mở URL_DEPLOYMENT/exec?page=teacher, nhập mã giáo viên, lọc lớp/tìm tên, xem ma trận đúng sai, chi tiết, CSV. Chấm 5 câu hoàn thành câu rồi Lưu điểm. Học viên bấm Cập nhật kết quả để nhận điểm cuối cùng. Mã giáo viên chỉ giữ trong bộ nhớ phiên, đăng xuất xóa dữ liệu.

## Làm thử
Mở HTML → Xem thử giao diện để xem pinyin/điền từ/câu viết. Teacher mở trực tiếp có Xem giao diện mẫu với dữ liệu giả, không phải bài học viên. Kiểm tra mô phỏng và trình duyệt không thay thế kiểm tra Apps Script/Sheets thật. Sau triển khai, nên tạo một lượt lớp THU_NGHIEM, nộp và đối chiếu Sheet/teacher.

## Bảo toàn bài làm
Timer dùng chung cả 5 phần, lưu nháp theo mã đề và lượt thi; đổi tab/layout không đặt lại thời gian. Bài đã nộp khóa, nộp lại trả kết quả đã lưu. Mất mạng giữ bài để gửi lại; tải JSON sao lưu không chứa token. Chỉ xem đáp án sau khi máy chủ xác nhận nộp. Điểm tự động được ghi rõ tạm tính khi còn câu tự viết chờ giáo viên.
