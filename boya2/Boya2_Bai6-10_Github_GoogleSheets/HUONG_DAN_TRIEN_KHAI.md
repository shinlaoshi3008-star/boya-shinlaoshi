# Triển khai bài kiểm tra Boya 2 bài 6–10

Bộ này dùng đúng 50 câu trong hai file Word đã soạn, gồm nghe 20 phút /30 điểm, đọc 25 phút /40 điểm và viết 15 phút /30 điểm. Giao diện là Naruto trong kỳ thi Chūnin; không thay đổi skill bài giảng Boya. Mỗi học viên ghi tên và lớp, không cần tài khoản Google.

## Các file trong gói

- `github-pages/index.html`: giao diện học viên; tranh, chữ Hán và 50 câu đã nhúng trong HTML.
- `github-pages/config.js`: kết nối máy chủ và đường dẫn audio.
- `github-pages/teacher-setup.html`: công cụ tạo config.js trên máy giáo viên.
- `github-pages/audio/`: đặt MP3 của bài nghe ở đây.
- `backend/Code.gs`: mã máy chủ và đáp án. **Chỉ đưa vào Google Apps Script. Không đưa thư mục backend hoặc toàn bộ gói ZIP lên repository công khai.**

Chỉ tải nội dung thư mục `github-pages` lên GitHub. Đáp án chấm nằm trong Apps Script của giáo viên, không nằm trong HTML học viên.

## 1 Tạo Google Sheet và Apps Script

1. Tạo một Google Sheet mới, ví dụ `Ket qua thi Boya 6-10`. Giữ Sheet ở chế độ Restricted; không bật chia sẻ cho tất cả học viên.
2. Trong Sheet chọn Extensions → Apps Script. Thay nội dung `Code.gs` bằng nội dung file `backend/Code.gs` trong gói.
3. Mở Project Settings → Script properties → Add script property. Thêm ba giá trị:

| Tên | Giá trị |
|---|---|
| `SHEET_ID` | Phần giữa `/d/` và `/edit` trong URL Google Sheet |
| `ALLOWED_ORIGIN` | Ví dụ `https://tentaikhoan.github.io`, **không** có `/ten-repository`, không có dấu `/` ở cuối |
| `EXAM_OPEN` | `true` để mở kỳ thi; `false` để chặn lượt mới |

Nếu dùng tên miền riêng, `ALLOWED_ORIGIN` phải là origin HTTPS đúng của trang thi, ví dụ `https://loptrung.example.com`.

4. Save, chọn hàm `setup` rồi Run. Cho phép quyền truy cập Sheet. Tab `KetQua` sẽ được tạo. Nếu menu chưa hiện, tải lại Google Sheet.
5. Deploy → New deployment → Web app. Execute as: **Me**. Who has access: **Anyone**. Deploy và sao chép URL kết thúc `/exec` (không dùng `/dev`). Nếu tài khoản trường không cho chọn Anyone, quản trị Google Workspace phải cho phép triển khai ẩn danh; không có chế độ này thì học viên chưa thể vào chỉ bằng tên/lớp.
6. Khi thay mã Code.gs, vào Deploy → Manage deployments → Edit → New version → Deploy. Save mã mà không triển khai phiên bản mới sẽ chưa cập nhật web app.

## 2 Chuẩn bị audio

Hiện bộ này chưa chứa audio đọc đề. Giáo viên có thể đọc trực tiếp hoặc thu kịch bản trong tài liệu đáp án Word.

- Khuyến nghị: thu một MP3 hoàn chỉnh cho câu 1–20, đã gồm hai lượt đọc, khoảng dừng và chỉ dẫn. Không để công cụ phát lặp toàn bộ file; hai lượt đọc đã nằm trong audio.
- Theo khung trong tài liệu giáo viên: 0:00–0:45 hướng dẫn; 0:45–5:20 câu 1–5; 5:20–11:10 câu 6–12; 11:10–19:10 câu 13–20; 19:10–20:00 rà soát.
- Đặt tên `boya6-10.mp3`, tải vào thư mục `audio/` trên GitHub. Đường dẫn cấu hình: `audio/boya6-10.mp3`. Giữ file dưới giới hạn GitHub cho một file; không dùng link trang xem Google Drive làm URL audio.
- Nếu tổ chức thi tập trung và giáo viên đọc thành tiếng, bật `liveReading: true`; lúc đó có thể để trống audioUrl. Thi từ xa cần MP3.
- Audio xuất hiện ngay đầu phần nghe. Trước khi vào thi, âm thử tai nghe chỉ là một tiếng bíp, không phát ngữ liệu đề.
- Học viên cần bấm ▶ nếu trình duyệt chặn tự phát sau khi ghi danh. Đồng hồ không dừng khi audio dừng; tập huấn và kiểm tra âm thanh trước giờ thi.
- Trong chế độ xem thử, chọn audio trên máy chỉ phục vụ xem thử trên máy đó, không tự tải lên GitHub.

## 3 Cấu hình và mở GitHub Pages

1. Tạo repository hoặc dùng repository hiện có. Chỉ upload nội dung thư mục `github-pages` vào nơi sẽ làm nguồn Pages; không upload `backend`.
2. Mở `teacher-setup.html` trên máy hoặc trang GitHub Pages đã bật. Dán URL Apps Script /exec, nhập `audio/boya6-10.mp3` hoặc chọn giáo viên đọc trực tiếp. Bấm **Tạo và tải config.js**.
3. Upload file `config.js` vừa tạo cạnh `index.html`, ghi đè file config rỗng. Trong config không có mật khẩu hoặc đáp án.
4. GitHub → Settings → Pages → Build and deployment → Source: Deploy from a branch. Chọn nhánh `main` và thư mục `/(root)` nếu các file ở gốc. Save. Nếu repository đã có website, đặt đề trong một thư mục như `kiem-tra-6-10/` và mở URL `https://tentaikhoan.github.io/repository/kiem-tra-6-10/` theo nguồn Pages hiện có.
5. Nếu là thư mục con, `config.js` và `audio/` vẫn phải cạnh `index.html` theo cấu trúc tương đối. File `.nojekyll` giúp xuất bản file tĩnh.
6. Mở URL Pages từ một thiết bị khác, kiểm tra đường dẫn audio rồi thực hiện một lượt thi thử. Xác minh Sheet có dòng tên/lớp và sau nộp có điểm nghe/đọc trước khi gửi link cho lớp.

## 4 Chấm viết và xem log

Tab `KetQua` lưu thời gian tạo, mã lượt thi, tên, lớp, thời gian bắt đầu/nộp, điểm nghe, đọc, viết, tổng điểm và trạng thái. Có thêm dấu nộp trễ, số lần rời tab, các câu trả lời và thông tin kỹ thuật để chống ghi trùng. Số lần rời tab chỉ là tín hiệu tham khảo, không tự kết luận gian lận.

- Nghe và đọc được máy chủ chấm, bỏ qua mọi điểm do trình duyệt tự gửi.
- Câu 41–50 lưu tại cột **R:AA**. Giáo viên nhập điểm từng câu 0–3 tại **AB:AK**. Điểm có thể là số thập phân.
- Nhập đủ 10 điểm, kể cả **0** cho câu bỏ trống. Hàm onEdit tự tổng hợp điểm viết vào J, tổng vào K, trạng thái L thành `Đã chấm`.
- Nếu thiếu hoặc có điểm không hợp lệ, điểm viết và tổng để trống, trạng thái `Chờ chấm viết`. Không ghi tổng 70 như thể đã chấm đủ 100 điểm.
- Khi chưa tự cập nhật, chọn menu **Boya Chunin → Tính lại điểm viết**. Chỉ sửa các cột AB:AK khi chấm; giữ nguyên cột mã lượt thi, thời gian, điểm nghe/đọc và Token hash.
- Học viên đã nộp có nút **Cập nhật điểm viết** để lấy kết quả mới. Không có trang danh sách điểm công khai.
- Đóng kỳ thi bằng `EXAM_OPEN=false` chỉ chặn đăng ký mới, không làm mất quyền nộp hoặc xem kết quả của lượt đã bắt đầu.

## 5 Cách vận hành và khôi phục

- Lượt thi bắt đầu khi máy chủ xác nhận đăng ký. Nghe → đọc → viết mở theo mốc 20/45/60 phút. Câu thuộc phần cũ bị khóa; phần tương lai chưa được mở.
- Hết 60 phút tự khóa bài và gửi. Có thể nộp sớm sau khi xác nhận, kể cả còn câu chưa làm.
- Bản nháp lưu trên trình duyệt. Tải lại và chọn **Tiếp tục lượt thi đang lưu** giữ đáp án và thời gian bắt đầu từ máy chủ; không được thêm 60 phút.
- Không xóa dữ liệu trình duyệt hoặc đổi máy giữa lượt thi. Trên máy dùng chung, giáo viên nên dùng hồ sơ trình duyệt riêng cho mỗi học viên; sau khi đã xác nhận nộp và tải bản sao, xóa dữ liệu website để chuẩn bị học viên khác. Có thể dùng cửa sổ ẩn danh cho mỗi lượt và chỉ đóng sau khi Sheet đã nhận bài.
- Khi mất mạng: bài vẫn giữ trên thiết bị. Học viên tải JSON bản sao và bấm Gửi lại khi mạng trở lại. File JSON bản sao không chứa token riêng của lượt thi.
- Máy chủ trả xác nhận sau khi ghi Sheet. Hệ thống **không** báo “đã lưu” chỉ dựa trên gửi một request không đọc được phản hồi. Gửi lại cùng mã lượt thi là idempotent, không tạo dòng trùng hoặc ghi đè bài đã nộp.
- Nhận sau 62 phút được gắn cờ nộp trễ để giáo viên xem xét, không tự xóa bài. Có khoảng 2 phút cho độ trễ mạng; mất mạng lâu hơn cần giáo viên đối chiếu bản sao.
- Lỗi “chưa nhận xác nhận”: kiểm tra ALLOWED_ORIGIN, quyền Anyone, URL /exec và triển khai New version; thử cửa sổ riêng không có tiện ích chặn iframe. Dữ liệu không bị tuyên bố đã lưu khi chưa xác nhận.

## Phạm vi kiểm tra và giới hạn

Bản này đã kiểm thử giao diện máy tính/điện thoại, lựa chọn câu, sắp xếp, nhập viết, khóa phần, tự nộp, khôi phục bản nháp, xác nhận POST/iframe, chấm nghe/đọc, chấm viết, token và chống ghi trùng bằng môi trường giả lập. **Chưa triển khai thử trên tài khoản Google Sheet và GitHub của giáo viên**, vì chưa có URL và quyền truy cập. Bắt buộc làm một lượt thử thật theo bước 3.6.

Tên/lớp là khai báo, không xác thực danh tính. Frontend tĩnh không ngăn hoàn toàn sửa JavaScript, sửa dữ liệu trình duyệt, mở tài liệu bên ngoài hoặc mạo danh. Đáp án và chấm điểm khách quan đặt ở Apps Script riêng để không lộ đáp án trong mã HTML, nhưng đây là kiểm tra lớp học, không phải hệ thống thi có giám sát chuyên nghiệp. Không tải mã backend vào kho công khai. Apps Script có hạn mức thực thi; thử tải tương ứng sĩ số trước kỳ thi đông học viên.

## Tài liệu nền tảng

- GitHub Pages: https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site
- Apps Script web apps: https://developers.google.com/apps-script/guides/web
- HtmlService iframe: https://developers.google.com/apps-script/reference/html/x-frame-options-mode

Backend dùng POST biểu mẫu và trả biên nhận qua postMessage trong iframe; targetOrigin là origin GitHub được cấu hình. Học viên chỉ nhận dữ liệu lượt thi của mình khi trình duyệt có token tương ứng. Không dùng JSONP để phát kết quả, không cho Google Sheet ở chế độ công khai.
