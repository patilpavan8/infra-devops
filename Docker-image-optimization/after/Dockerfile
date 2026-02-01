# ---------- Builder Stage ----------
FROM node:18-alpine AS builder

WORKDIR /app

COPY app/package*.json ./

RUN npm ci --only=production

COPY app/ .

# ---------- Runtime Stage ----------
FROM node:18-alpine

WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app /app

USER appuser

EXPOSE 3000

CMD ["node", "index.js"]
