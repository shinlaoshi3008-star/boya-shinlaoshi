# HƯỚNG DẪN GEMINI · Đề 1 · Boya 2 bài 1–5

**BẢN GEMINI. Cấu hình khóa duy nhất: GEMINI_API_KEY.**

Bản Gemini giữ cùng mã đề, cấu trúc Sheet, bài làm, điểm cũ và lịch sử của bản AI vừa tạo; giữ 19 câu, 30 phút, tổng 100 điểm:

| Bài | Số câu | Điểm/câu | Tổng | Cách làm/chấm |
|---|---:|---:|---:|---|
| 1 | 5 | 4 | 20 | Dropdown ngay chỗ trống, chấm cố định |
| 2 | 5 | 4 | 20 | Nhập câu viết lại, AI chấm HSK3 |
| 3 | 5 | 8 | 40 | Bấm sắp xếp các ô từ, chấm các thứ tự hợp lệ |
| 4 | 4 | 5 | 20 | Nhập câu trả lời đọc hiểu, AI chấm HSK3 |

Câu đạt tối đa: chỉ hiện điểm và bài làm, không giải thích. Câu chưa tối đa: bắt buộc có lý do bị trừ điểm và câu sửa tham khảo. Điểm AI tự công bố; giáo viên không cần duyệt trước, vẫn có thể chỉnh sau.

## 1. Lấy đúng các file

- `github-pages/Boya2_KiemTra1_1-5_AI.html`: file học viên, chỉ file này đưa lên GitHub.
- `private-apps-script/Code.gs`: backend riêng, chấm cố định + AI + lưu điểm và lịch sử.
- `private-apps-script/teacher.html`: trang giáo viên, phải tạo trong Apps Script.
- `private-apps-script/DAP_AN_VA_TIEU_CHI.md`: đáp án, rubric chi tiết và các chỉnh lỗi in.
- `LICENSE_FONT.txt`: giấy phép font nhúng.

Không đưa ZIP, Code.gs, teacher.html hay đáp án lên repository công khai. File học viên có thể mở trực tiếp để xem thử, nhưng xem thử không chấm hoặc gửi bài.

## 2. Cấu hình Gemini miễn phí

### Nếu đã triển khai bản AI trước đó

Không tạo Sheet/dự án mới. Giữ nguyên SHEET_ID, ALLOWED_ORIGIN, TEACHER_KEY, EXAM_OPEN, mã đề và URL /exec.

1. Thay toàn bộ Code.gs bằng bản trong ZIP này.
2. Thay nội dung file HTML **teacher** trong Apps Script bằng teacher.html mới.
3. Thêm các thuộc tính Gemini bên dưới. Các thuộc tính khóa/model của nhà cung cấp trước không được bản Gemini sử dụng.
4. Giữ trigger processAIQueue_ đang có, hoặc chạy installAITrigger để tạo nếu thiếu. Khi nâng cấp nên đóng thi tạm bằng EXAM_OPEN=false, đợi các lượt xử lý cũ hoàn tất trước khi thay backend; mở lại khi cấu hình xong.
5. Triển khai → Quản lý triển khai → bút chì → Phiên bản mới → Triển khai để giữ URL cũ. Bản HTML học viên đang dùng vẫn tương thích, không cần đổi link hay index. Nếu thay bằng HTML trong ZIP này, chép endpoint /exec hiện tại vào window.EXAM_CONFIG trước khi tải lên GitHub.
6. Các bài còn chờ AI tiếp tục chấm bằng Gemini. Bài trước đó ở trạng thái failed: sau khi sửa cấu hình, vào teacher → Xem bài → Đưa lại vào hàng chờ AI. Không chấm lại hoặc ghi đè các câu đã có điểm.

### Nếu chưa triển khai

1. Tạo Sheet “Boya2_Bai1-5_AI”; Tiện ích mở rộng → Apps Script.
2. Dán private-apps-script/Code.gs vào Code.gs, lưu.
3. Bấm + → HTML, đặt tên chính xác **teacher**, dán private-apps-script/teacher.html.
4. Sau đó thực hiện các bước lấy khóa và cấu hình dưới đây.

### Lấy khóa từ dự án Free Tier

1. Mở https://aistudio.google.com/ bằng tài khoản Google của bạn.
2. Vào API keys / Get API key và tạo khóa cho dự án dùng để chấm bài.
3. Kiểm tra dự án ở trang Projects: chọn dự án đang ở **Free Tier**. Không bật/nâng cấp Billing cho dự án này nếu mục tiêu là chỉ dùng miễn phí. Chọn model có Free Tier và được phép dùng trong dự án của bạn; ví dụ cấu hình dưới đây dùng gemini-2.5-flash-lite theo bảng giá đã đối chiếu.
4. Xem hạn mức thực ở https://aistudio.google.com/usage?tab=rate-limit . Hạn mức theo dự án/model, không mặc định số lượt/ngày cho mọi tài khoản. Model không hiện hạn mức miễn phí hoặc hạn mức bằng 0 thì không coi là có thể dùng miễn phí; chọn model có quyền dùng Free Tier hoặc chờ tài khoản được cấp hạn mức, không tự bật Billing để khắc phục.

Trong Apps Script → Cài đặt dự án → Thuộc tính tập lệnh, cấu hình:

| Thuộc tính | Giá trị |
|---|---|
| SHEET_ID | Mã giữa /d/ và /edit trong URL Sheet (giữ nguyên nếu đã triển khai) |
| ALLOWED_ORIGIN | https://shinlaoshi3008-star.github.io |
| EXAM_OPEN | false khi chuẩn bị; true khi mở thi |
| TEACHER_KEY | Mã giáo viên riêng ít nhất 16 ký tự (giữ nguyên mã cũ) |
| GEMINI_API_KEY | Khóa API tạo trong Google AI Studio, không phải mật khẩu Google |
| GEMINI_MODEL | gemini-2.5-flash-lite hoặc model hỗ trợ JSON có Free Tier mà dự án được cấp quyền |
| GEMINI_ENABLED | true |
| GEMINI_FREE_TIER_CONFIRMED | true sau khi bạn kiểm tra dự án đang dùng Free Tier |
| AI_DAILY_LIMIT | 20 để bắt đầu; đây là mức trần do bạn đặt, có thể giảm/tăng theo hạn mức thực |
| GEMINI_MIN_INTERVAL_SECONDS | 65 (khoảng cách tối thiểu giữa hai lần gọi; tối thiểu cho phép là 60) |

ALLOWED_ORIGIN không có /boya-shinlaoshi/ hoặc dấu / cuối. Không đưa GEMINI_API_KEY hay TEACHER_KEY vào HTML hoặc GitHub.

GEMINI_FREE_TIER_CONFIRMED là xác nhận cấu hình của bạn, **không phải phép kiểm tra billing tự động**. API chấm không cho mã này xác minh chắc chắn gói thanh toán của dự án. Mã không nâng cấp Billing, không đổi sang nhà cung cấp/model khác và không chuyển sang endpoint trả phí; nếu bạn tự bật Billing cho chính dự án/khóa đang dùng, Google vẫn có thể tính phí các lệnh gọi. Muốn chỉ dùng miễn phí, cần duy trì dự án Free Tier không bật Billing.

Gói miễn phí có thể dùng nội dung gửi/nhận để cải thiện sản phẩm Google. Mã chỉ gửi đề/rubric/câu trả lời, không kèm tên/lớp/token; nhắc học sinh không ghi thông tin riêng tư trong nội dung trả lời. Nếu học sinh tự gõ thông tin cá nhân vào câu trả lời thì nội dung đó vẫn được gửi.

## 3. Khởi tạo bảng và bật chấm tự động

1. Trong Apps Script, chọn hàm **setup → Chạy**, cấp quyền.
2. Chọn hàm **installAITrigger → Chạy**, cấp quyền truy cập dịch vụ ngoài và tạo lịch.
3. Mở mục **Trình kích hoạt / Triggers** bên trái, xác nhận có hàm `processAIQueue_`, loại theo thời gian, mỗi phút. Hàm có dấu `_` là worker nội bộ, không phải API học viên.
4. `installAITrigger` không tạo thêm bản trùng khi chạy lại. Nếu chấm dừng vì hết hạn quyền, cấp quyền lại bằng tài khoản sở hữu dự án.

Các tab được tạo:

| Tab | Nội dung |
|---|---|
| KetQua_Bai1_5_AI_v1 | Tên/lớp, thời gian, điểm từng bài, tổng, điểm đã có, bài làm, chấm gốc, điều chỉnh, trạng thái AI |
| CauCanOn_Bai1_5_AI_v1 | Các câu đã chấm nhưng chưa tối đa; không tính câu chờ AI là sai |
| LichSuDiem_Bai1_5_AI_v1 | Điểm trước/sau, lý do, thời gian và phiên bản mỗi lần giáo viên sửa |
| LuuTru_Xoa_Bai1_5_AI_v1 | Bản sao đầy đủ trước khi xóa lượt thi |

Không chỉnh tay các cột JSON, token hash, phiên bản và hàng chờ. Muốn sửa điểm hãy dùng teacher.html để tổng điểm và lịch sử được cập nhật đồng bộ.

## 4. Triển khai và nối vào HTML

1. **Triển khai → Triển khai mới → Ứng dụng web**.
2. Thực thi dưới quyền **Tôi**; quyền truy cập **Bất kỳ ai**. Triển khai và sao chép URL kết thúc `/exec` (không dùng `/dev`).
3. Trong HTML học viên, tìm duy nhất `window.EXAM_CONFIG`. Thay `endpoint:''` thành:

```javascript
endpoint:'https://script.google.com/macros/s/MA_TRIEN_KHAI_CUA_BAN/exec'
```

Giữ `examId:'BOYA2-1-5-TEST01-AI-V1'` và thời gian 30 phút.
4. Sau khi thử thành công, đặt EXAM_OPEN=`true` để mở thi.
5. Đưa **Boya2_KiemTra1_1-5_AI.html** vào thư mục **boya 2** trên GitHub theo cấu trúc hiện tại.
6. Ở index tổng, thêm **mục riêng “Kiểm tra 1–5 · Chấm AI”**, không thay/xóa đề cũ. Đường dẫn từ index gốc: `boya%202/Boya2_KiemTra1_1-5_AI.html`. Nếu cấu trúc index hiện tại dùng đối tượng TESTS/additional, thêm trong cấu trúc đó, không dán HTML rời vào JavaScript. Bộ này không sửa index cũ vì chưa có bản index hiện tại để đối chiếu.
7. Trang giáo viên mở bằng **URL_EXEC_CUA_BAN?page=teacher**, nhập TEACHER_KEY. Không mở teacher.html trực tiếp trên GitHub để kết nối API.

## 5. Khi học sinh nộp bài

- Bài làm lưu vào Sheet trước khi gọi AI. Nộp lặp cùng mã lượt chỉ trả kết quả đã lưu, không tạo bài mới hoặc gọi AI lại.
- Bài 1 và 3 chấm ngay (tối đa 60 điểm). Bài 2 và 4 có câu nhập chưa chấm thì hiển thị **Chờ chấm AI**; tổng hiển thị **Chờ**, bên cạnh có điểm đã có. Không coi điểm đã có là tổng cuối.
- Câu bỏ trống được chấm 0 với lý do “Bỏ trống câu trả lời”, không tốn lượt gọi Gemini.
- Worker chạy qua trigger, gom bài 2 và bài 4 còn chờ của một học sinh vào một yêu cầu. Mỗi lần trigger xử lý tối đa một bài; có lease toàn cục và giãn ít nhất 65 giây giữa hai lần gọi theo cấu hình mẫu. Với trigger mỗi phút, thực tế có thể khoảng hai phút mới bắt đầu bài kế tiếp; nhiều học sinh nộp cùng lúc sẽ chấm nối tiếp. Không bảo đảm điểm AI có ngay tức thì.
- AI chỉ nhận đề, đoạn văn, rubric và câu trả lời; không gửi tên, lớp hay token. Lưu ý nếu học sinh tự ghi thông tin cá nhân vào nội dung trả lời thì nội dung đó vẫn được gửi cùng bài.
- AI trả điểm từng tiêu chí; máy chủ kiểm tra đúng mã câu, giới hạn điểm, bước 0.5 và yêu cầu giải thích câu bị trừ. Điểm tổng do máy chủ tự cộng; không tin tổng điểm do trình duyệt hoặc AI gửi.
- Kết quả tự công bố vào Sheet và giao diện. Trang học sinh đang mở tự kiểm tra khoảng 15 giây/lần khi còn câu chờ; có nút Cập nhật kết quả. Nếu giáo viên sửa sau khi đã chấm xong, học sinh bấm cập nhật để lấy điểm mới.
- Giới hạn lượt/token (HTTP 429) và lỗi dịch vụ tạm thời (5xx/408) được chờ rồi tự thử lại với khoảng chờ tăng dần. Nhiều lần bị giới hạn không làm bài thành 0 hoặc bị đánh dấu hết lượt thử vĩnh viễn.
- Nếu Gemini báo hết quota theo ngày, hàng chờ tạm dừng đến sau nửa đêm giờ Pacific (cộng đệm 5 phút), rồi tự thử lại. AI_DAILY_LIMIT cũng tính theo ngày Pacific; đây là giới hạn nội bộ, không biết các lượt bạn dùng ở ứng dụng khác cùng dự án. Nếu hết quota thực nhưng thông báo không nêu rõ quota ngày, hệ thống tăng thời gian chờ và thử lại trong giới hạn nội bộ, không khẳng định nhận diện được mọi trường hợp.
- Lỗi cấu hình 400/401/403/404 dừng hàng chờ để giáo viên kiểm tra, không gọi lặp cho cả lớp. Sửa khóa/model/quyền truy cập, sau đó đưa lại một bài lỗi vào hàng chờ từ teacher để mở lại. Nếu vẫn sai, hệ thống lại dừng.
- Kết quả JSON sai/điểm vượt giới hạn/thiếu lý do bị trừ chỉ thử tối đa 3 lần nhận kết quả không hợp lệ, sau đó chờ giáo viên kiểm tra. Bài làm luôn được giữ, không tự cho 0.
- Lượt gửi/nhận mất kết nối có thể đã tiêu tốn quota ở Google trước khi hệ thống nhận được phản hồi. Không có cam kết miễn phí vô hạn hoặc chấm hết mọi bài trong cùng ngày.

## 6. Giáo viên kiểm tra và sửa điểm

Mở teacher, lọc lớp, tên/mã lượt, từ ngày–đến ngày. Cả ngày kết thúc được tính. Điểm đã hoàn tất xếp giảm dần; bài chờ AI nằm dưới và không bị đưa vào trung bình/nhóm dưới 50.

- **Học sinh → Xem bài**: mặc định câu chưa tối đa/chờ chấm; có Toàn bộ bài. Câu tối đa chỉ điểm và bài làm. Câu chưa tối đa có lý do, điểm từng tiêu chí khi có và câu sửa.
- **Điều chỉnh điểm**: nhập điểm mới (bước 0.5) và lý do. Lưu xong tự cập nhật điểm từng phần/tổng, log câu cần ôn và lịch sử. Có thể sửa bất kỳ câu nào, kể cả bài 1/3 hoặc câu còn chờ AI. Điểm giáo viên ưu tiên hơn AI.
- Nếu giáo viên sửa khi AI đang chạy, điểm sửa vẫn được giữ; kết quả AI gốc lưu riêng. Nếu bài thay đổi sau lúc mở hộp sửa, máy chủ yêu cầu làm mới để tránh ghi đè điểm mới hơn.
- Câu giáo viên sửa về tối đa không hiển thị giải thích cho học sinh; lý do sửa vẫn có trong LichSuDiem. Nếu AI gốc chưa tối đa, giáo viên có thể mở “Lý do trừ điểm ban đầu của AI”.
- **Bảng đúng/sai**: ✓ tối đa, ◐ một phần, ✕ sai, — bỏ trống, … chờ. Bấm ô để xem câu; bấm số câu để xem học sinh cần chữa.
- **Câu cần ôn**: tỷ lệ tính trên những câu đã chấm; không tính pending là sai.
- **Đưa lại vào hàng chờ AI**: chỉ dành bài còn câu chưa chấm, sau khi sửa lỗi cấu hình/mạng. Không chấm lại câu đã có điểm, không mất điểm giáo viên và không bỏ qua thời gian chờ quota chung. Bảng Gemini phía trên cho biết model, lượt đã dùng/giới hạn nội bộ, trạng thái sẵn sàng hoặc thời điểm chờ tiếp.
- **Xuất CSV**: đúng bộ lọc và thứ tự đang thấy; có điểm từng câu, từng phần, tổng, trạng thái và câu chờ.
- **Xóa**: xác nhận đúng tên/lớp/lượt; lưu bản sao trước, rồi gỡ kết quả và log lỗi. Không xóa lịch sử sửa điểm. Cần khôi phục thì sao chép dòng lưu trữ **bỏ cột “Xóa lúc”** về tab KetQua cùng schema; không nhập hai dòng cùng mã lượt. Worker đang chạy sẽ không ghi lại dòng đã xóa.
- **Đăng xuất**: xóa mã và dữ liệu đang hiển thị khỏi bộ nhớ trang. Mã không lưu localStorage và không đặt trên URL.

## 7. Thử trước khi dùng trên lớp

1. Mở HTML từ GitHub; ghi tên “THỬ NGHIỆM” và lớp “TEST”.
2. Điền cả hai phần AI, chọn/ghép các câu còn lại, nộp.
3. Xác nhận Sheet lưu ngay, phần AI hiện chờ; sau một vài lượt trigger phải có điểm và tổng.
4. Trên teacher, mở bài, đối chiếu một câu đúng và một câu chưa tối đa: câu đúng không giải thích, câu trừ điểm có lý do.
5. Thử sửa một câu, kiểm tra tổng trong teacher/Sheet và bấm cập nhật bên học sinh.
6. Sau khi thử xong xóa đúng lượt TEST trên teacher. Giữ các lượt thật riêng.

Bộ mã đã được kiểm tra bằng backend và trình duyệt mô phỏng: chấm 60+40, bỏ trống, JSON AI sai/lỗi HTTP, thử lại, khóa bài, gửi lặp, ghi đè điểm khi AI đang chạy, điểm tối đa không nhận xét, điểm chưa tối đa phải có lý do, điện thoại 320–430px và máy tính. **Chưa gọi API AI hoặc ghi Google Sheets thật**, vì chưa có khóa/endpoint của bạn. Chất lượng chấm nội dung thực cần được đối chiếu trên bài thử khi bạn cấu hình API.

## 8. Xử lý khi điểm Gemini chưa về

| Hiện tượng | Cách kiểm tra |
|---|---|
| Chưa gọi AI, không có lỗi | Xem bảng Gemini trên teacher; kiểm tra ENABLED, FREE_TIER_CONFIRMED, API_KEY, MODEL và trigger |
| Đã đạt giới hạn nội bộ | Chờ sang ngày Pacific tiếp theo; chỉ tăng AI_DAILY_LIMIT khi hạn mức thực cho phép |
| GEMINI_HTTP_429 | Chờ tự thử lại; xem quota thực trong AI Studio. Không tạo nhiều khóa để né giới hạn vì quota tính theo dự án |
| Hết quota ngày | Giữ bài chờ; sau mốc Pacific hệ thống tiếp tục tự thử |
| GEMINI_HTTP_400 | Kiểm tra model có hỗ trợ schema và dự án/khu vực có quyền dùng Free Tier |
| GEMINI_HTTP_401 / 403 | Kiểm tra khóa, giới hạn khóa, quyền dự án; sửa xong đưa lại bài lỗi vào hàng chờ |
| GEMINI_HTTP_404 | Model không tồn tại/đã ngừng cung cấp hoặc tài khoản không được dùng; chọn đúng ID model Free Tier có trong dự án |
| GEMINI_HTTP_5xx / 408 | Dịch vụ tạm lỗi, tự chờ và thử lại |
| GEMINI_JSON / GEMINI_EMPTY / GEMINI_BLOCKED / GEMINI_INCOMPLETE | Không nhập điểm từ phản hồi thiếu/sai/bị chặn; xem bài gốc, cấu hình model rồi thử lại |
| AI_SCHEMA / AI_CRITERIA / AI_SCORE / AI_REASON_REQUIRED | Kiểm tra chấm AI trả đủ tiêu chí và lý do, không nhận điểm không hợp lệ |
| Sửa backend mà chưa đổi | Quản lý triển khai → Sửa → Phiên bản mới; giữ URL /exec |

Không cần máy giáo viên/học sinh bật liên tục để worker chạy: trigger thuộc dự án Apps Script. Thời gian xử lý còn phụ thuộc quota Gemini và Apps Script. Nếu cần điểm sớm khi quota hết, giáo viên vẫn có thể chấm tay trên teacher.

## Tài liệu đối chiếu

- Tạo khóa: https://aistudio.google.com/apikey
- Giá và model Free Tier: https://ai.google.dev/gemini-api/docs/pricing
- Hạn mức/reset Pacific: https://ai.google.dev/gemini-api/docs/rate-limits
- JSON output: https://ai.google.dev/gemini-api/docs/generate-content/structured-output
- Xử lý lỗi/backoff: https://ai.google.dev/gemini-api/docs/troubleshooting
- Trigger Apps Script: https://developers.google.com/apps-script/guides/triggers/installable
