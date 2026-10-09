# Bài kiểm tra số 3 · Boya 2 · Bài 11–15

## Nội dung

- 30 phút, dùng chung cả 5 phần. Chuyển phần tự do, đồng hồ không đặt lại.
- 26 câu, tổng 100 điểm: bổ ngữ kết quả 15; hội thoại 30; chọn đáp án 15; sửa câu 20; diễn đạt 20.
- Chấm tự động trên Apps Script; học viên xem điểm, câu sai/bỏ trống, đáp án đúng và giải thích sau khi máy chủ xác nhận lưu.
- Đề PDF gốc có các phần tự viết. Bản online đổi phần II, IV sang lựa chọn; phần V đổi bài viết /20 thành 5 câu lựa chọn /4, giữ chủ đề chuyện khiến mình phiền lòng. Không chấm bài văn tự do.
- Phần I có ngân hàng 5 từ: 成、好、懂、走、掉. Từ có thể dùng lại. Cả 5 câu nằm trên một trang, chọn ngay tại chỗ trống.
- Thông tin ghi danh chỉ là Họ tên/Lớp; không xác minh bằng tài khoản hay mật khẩu.

## 1. Lấy đúng các file

```
Boya2_KiemTra3_11-15/
  github-pages/
    Boya2_KiemTra3_11-15.html       ← file đưa lên GitHub
  private-apps-script/
    Code.gs                      ← chỉ dán vào Google Apps Script
    Dap_an_giao_vien.md           ← giáo viên giữ riêng
  HUONG_DAN.md
  LICENSE_FONT.txt
```

Chỉ đưa HTML trong `github-pages` lên repository công khai. Không đưa ZIP, thư mục `private-apps-script` hoặc đáp án lên GitHub.

Mở HTML trên máy sẽ xem thử được giao diện. Xem thử không chấm, không gửi dữ liệu. Thi thật cần triển khai backend và điền URL như dưới đây.

## 2. Tạo Google Sheets và Apps Script riêng cho đề số 3

Các bước này tạo hệ thống riêng, không cần thay Code.gs của bài kiểm tra cũ.

1. Tạo Google Sheet mới, đặt tên “Boya 2 – Kiểm tra 3 – Bài 11–15”.
2. Trong Sheet: **Tiện ích mở rộng → Apps Script**.
3. Xóa code mặc định ở dự án mới, dán toàn bộ nội dung `private-apps-script/Code.gs`, lưu.
4. Mở **Cài đặt dự án → Thuộc tính tập lệnh → Thêm thuộc tính**:

| Tên | Giá trị |
| --- | --- |
| `SHEET_ID` | Phần giữa `/d/` và `/edit` trong URL Google Sheet vừa tạo |
| `ALLOWED_ORIGIN` | `https://shinlaoshi3008-star.github.io` |
| `EXAM_OPEN` | `true` |

`ALLOWED_ORIGIN` không chứa `/boya-shinlaoshi/` và không có dấu `/` cuối. Nếu đổi tên miền GitHub, sửa origin tương ứng.

5. Chọn hàm **setup**, bấm **Chạy**, cấp quyền cho dự án. Script tạo hai tab:
   - `KetQua_Bai11_15_So3`: mỗi lượt thi một dòng; tên/lớp, giờ thi, điểm từng phần, tổng, câu sai và bài làm.
   - `CauSai_Bai11_15_So3`: mỗi câu sai/bỏ trống một dòng; tên/lớp, số câu, đáp án học viên, đáp án đúng và giải thích.
6. Bấm **Triển khai → Triển khai mới → Ứng dụng web**:
   - **Thực thi dưới quyền**: Tôi.
   - **Ai có quyền truy cập**: Bất kỳ ai.
   - Bấm Triển khai, sao chép URL ứng dụng web kết thúc bằng `/exec`.

Nếu tài khoản tổ chức không cho chọn “Bất kỳ ai”, dùng tài khoản/dự án cho phép học viên truy cập. Đường dẫn `/dev` không dùng cho học viên.

## 3. Điền URL vào HTML và tải lên GitHub

1. Mở `Boya2_KiemTra3_11-15.html` bằng VS Code hoặc Notepad.
2. Tìm `window.EXAM_CONFIG`, thay duy nhất giá trị `endpoint:''` bằng URL `/exec` vừa sao chép:

```javascript
window.EXAM_CONFIG={
  endpoint:'https://script.google.com/macros/s/MA_TRIEN_KHAI_CUA_BAN/exec',
  title:'Boya 2 · Kiểm tra số 3 · Bài 11–15',
  examId:'BOYA2-11-15-TEST03-AUTO',
  durationMinutes:30
};
```

Địa chỉ trên là mẫu, cần thay bằng URL của bạn. Không đổi `examId`; mã phải khớp Code.gs.

3. Giữ cấu trúc hiện tại: đặt HTML mới trực tiếp trong thư mục **`boya 2`**, cùng cấp với các bài giảng. Không ghi đè các đề cũ.
4. Commit file lên GitHub. Đợi GitHub Pages hoàn tất cập nhật.
5. Đường dẫn dự kiến khi tên thư mục đúng là `boya 2`:

`https://shinlaoshi3008-star.github.io/boya-shinlaoshi/boya%202/Boya2_KiemTra3_11-15.html`

Nút biểu tượng nhà trong HTML dùng `../index.html`, phù hợp với `index.html` tổng nằm ở thư mục gốc. Nếu để file đề trong thư mục con khác, điều chỉnh nút nhà theo vị trí thực tế.

## 4. Nối vào index tổng mà vẫn giữ các bài kiểm tra cũ

Bạn chưa cung cấp index trong lượt này, nên bộ file không thay hoặc xóa mục cũ.

Thêm một mục riêng tên **“Kiểm tra số 3 · Bài 11–15 · 30 phút”**, trỏ tới:

```html
<a href="boya%202/Boya2_KiemTra3_11-15.html">Kiểm tra số 3 · Bài 11–15 · 30 phút</a>
```

Đây là đường dẫn tính từ index gốc. Giữ nguyên các mục kiểm tra đã có. Nếu index dùng bộ quản lý `TESTS` hoặc công cụ thêm bài của bạn, thêm đề này qua công cụ với cùng tên và đường dẫn; không thay link chính của đề cũ.

## 5. Thử trước khi giao cho lớp

1. Truy cập trang trên GitHub Pages, nhập tên **“THỬ HỆ THỐNG”**, lớp **“TEST”**, đánh dấu đồng ý, vào thi.
2. Kiểm tra đổi đủ 5 phần và lựa chọn Đổi giao diện. Đáp án, thời gian phải giữ nguyên khi đổi tab hoặc tải lại rồi chọn Tiếp tục lượt thi.
3. Cố ý chọn sai một câu và bỏ trống một câu, bấm Nộp bài → Xác nhận nộp.
4. Chờ thông báo đã xác nhận lưu; đối chiếu điểm, câu sai và hai bảng Google Sheets.
5. Bấm cập nhật kết quả hoặc gửi lại nếu mạng gián đoạn. Cùng mã lượt thi chỉ ghi một kết quả và không thay bài đã nộp.
6. Nếu mạng lỗi, học viên tải bản sao JSON; file không chứa token. Giữ file để giáo viên đối chiếu khi cần, không coi bản sao là bằng chứng bài đã được gửi thành công.

Đã kiểm tra bằng backend mô phỏng và trình duyệt: điểm tối đa/0, câu bỏ trống, nộp lặp, khôi phục, hết giờ, chuyển phần và bố cục 320–1440px. Chưa kiểm tra ghi Google Sheets thật vì chưa có URL deployment của bạn. Kiểm tra điện thoại là mô phỏng kích thước, không phải thử trên thiết bị iPhone thật.

## 6. Theo dõi lớp và đóng kỳ thi

- Mở tab `KetQua_Bai11_15_So3`, lọc theo lớp để xem điểm từng học viên và danh sách số câu sai.
- Tab `CauSai_Bai11_15_So3`: lọc theo tên/lớp để biết một học viên sai câu nào; lọc theo số câu để biết câu nào nhiều học viên sai.
- Nếu bảng câu sai chưa đồng bộ, chạy hàm `dongBoCauSai` trong Apps Script hoặc học viên bấm cập nhật kết quả.
- Đổi `EXAM_OPEN` thành `false` để chặn lượt mới. Học viên đã vào thi vẫn được nộp/tra kết quả.
- Khi sửa Code.gs về sau: **Triển khai → Quản lý triển khai → Sửa → Phiên bản mới → Triển khai** để giữ URL `/exec`. Chỉ sửa dự án đề số 3.
- Bài nhận quá 32 phút được đánh dấu nộp trễ. Vẫn ghi điểm để giáo viên xem xét thời điểm nhận và lỗi mạng. Lượt thi lưu hash token, không lưu token gốc. Nhật ký rời tab chỉ hỗ trợ theo dõi, không phải kết luận học viên gian lận.
- Một thiết bị/trình duyệt giữ một lượt thi thật cho đề này. Nếu dùng chung máy, học viên nên dùng hồ sơ trình duyệt riêng; chỉ xóa dữ liệu trang sau khi đã xác nhận lưu kết quả của người trước.

## Ghi chú nguồn

Nội dung xây từ “Boya2_Bài kiểm tra số 3_TBD (11-15)-trang.pdf” do giáo viên cung cấp. Không thêm phần nghe vào đề ngữ pháp. Đáp án và các điểm chỉnh ngữ cảnh nằm trong file giáo viên riêng.
