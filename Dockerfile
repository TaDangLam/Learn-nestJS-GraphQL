# 1. Dùng image Node chính thức
FROM node:18

# 2. Tạo thư mục làm việc bên trong container
WORKDIR /app

# 3. Copy file package.json và package-lock.json trước (để cache layer)
COPY package*.json ./

# 4. Cài đặt dependencies
RUN npm install

# 5. Copy thư mục prisma vào container
COPY prisma ./prisma

# 6. Chạy lệnh Prisma generate để tạo Prisma client
RUN npx prisma generate

# 7. Copy toàn bộ project (trừ file bị .dockerignore)
COPY . .

# 8. Biên dịch TypeScript => JavaScript (ra thư mục dist/)
RUN npm run build

# 9. Mở cổng NestJS (thường dùng port 3000)
EXPOSE 3000

# 10. Chạy ứng dụng từ thư mục dist
CMD ["node", "dist/main"]
