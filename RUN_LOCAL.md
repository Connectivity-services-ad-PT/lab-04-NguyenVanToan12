# RUN_LOCAL.md – Hướng dẫn chạy Lab 04 (team-analytics)

Tài liệu này hướng dẫn chi tiết cách build, chạy và kiểm thử dịch vụ Alert & Analytics (team-analytics) trong môi trường Docker.

---

## 1. Chuẩn bị môi trường

Yêu cầu đã cài đặt sẵn trên máy:
- Docker Desktop hoặc Docker Engine
- Node.js 20.x LTS và npm
- Python 3.11+ (nếu muốn chạy thử local không dùng Docker)

Cài đặt các dependencies phục vụ Prism, Spectral, Newman:
```bash
npm install
```

---

## 2. Build Docker Image

Build Docker image từ Dockerfile bằng lệnh:
```bash
docker build -t fit4110/analytics-alert:lab04 .
```
Hoặc dùng lệnh nhanh qua Makefile:
```bash
make build
```

---

## 3. Chạy Container từ Image

Khởi chạy container từ image vừa build với cấu hình cổng 8000 và file môi trường mẫu `.env.example`:
```bash
docker run --rm \
  --name fit4110-analytics-lab04 \
  -p 8000:8000 \
  --env-file .env.example \
  fit4110/analytics-alert:lab04
```
Hoặc dùng lệnh nhanh qua Makefile:
```bash
make run
```

---

## 4. Kiểm tra sức khỏe dịch vụ (Health Check)

Kiểm tra xem container đã chạy và dịch vụ sẵn sàng chưa:
```bash
curl http://localhost:8000/health
```

Kết quả mong đợi:
```json
{
  "status": "UP"
}
```

---

## 5. Chạy Newman Verification trên Container

Mở một terminal khác và chạy Newman test suite trên local container:
```bash
npm run test:local
```
Hoặc dùng lệnh nhanh qua Makefile:
```bash
make test-docker
```

Các Newman reports sẽ được lưu trữ trong thư mục:
- `reports/newman-lab04-local.xml`
- `reports/newman-lab04-local.html`

---

## 6. Dừng Container

Để dừng và xóa container đang chạy:
```bash
docker stop fit4110-analytics-lab04
```
Hoặc dùng lệnh nhanh qua Makefile:
```bash
make stop
```

---

## 7. Các lệnh nhanh qua Makefile

- `make build`: Build Docker image
- `make run`: Chạy container
- `make test-docker`: Chạy Newman test suite trên container
- `make stop`: Dừng container
