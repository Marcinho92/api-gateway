# API Gateway

This is a Spring Cloud Gateway application that acts as an API gateway for your language learning backend.

## Recent Fixes

### Issue Fixed
- **Deprecated dependency**: Replaced `spring-cloud-starter-gateway` with `spring-cloud-starter-gateway-server-webflux`
- **Missing RequestRateLimiter**: Removed rate limiting to fix startup issues

### Changes Made
1. Updated `pom.xml`:
   - Replaced deprecated gateway starter with `spring-cloud-starter-gateway-server-webflux`
   - Added Resilience4j Circuit Breaker dependency
   - Removed Redis dependency

2. Updated `application.yml`:
   - Removed Redis configuration
   - Added Circuit Breaker with fallback mechanism
   - Added HTTP client optimization (connection pooling, compression)
   - Added Netty server optimization
   - Added cache for paginated endpoints
   - Configured for Railway deployment

3. Added configuration classes:
   - `CorsFilter.java` - CORS header management
   - `FallbackController.java` - Circuit breaker fallback responses

## Current Configuration

### API Gateway Routes
- **Main API Route**: `/api/**` → Backend service (with Circuit Breaker)
- **Cached Paginated**: `/api/words/paginated` → Backend service (2min cache)
- **Health Check**: `/actuator/health` → Backend service
- **Fallback**: `/fallback` → Error response when backend is down
- **CORS**: Configured for specific origins with duplicate header removal

### Performance Optimizations
- **Connection Pooling**: 100 max connections, 30s idle time
- **Compression**: Gzip compression enabled
- **Caching**: 2-minute cache for paginated endpoints
- **Circuit Breaker**: 50% failure threshold, 30s recovery time
- **Netty Tuning**: Optimized buffers and timeouts

## Environment Variables for Railway

```bash
# Required
BACKEND_URL=https://your-backend-url.up.railway.app

# Optional
PORT=8080
```

## Testing

After deployment, you can test the gateway:

```bash
# Test main API route
curl -X GET https://your-gateway-url.up.railway.app/api/health

# Test health endpoint
curl -X GET https://your-gateway-url.up.railway.app/actuator/health
```

## Troubleshooting

If you encounter startup issues:

1. **Check dependencies**: Ensure `spring-cloud-starter-gateway-server-webflux` is in your `pom.xml`
2. **Check configuration**: Verify `application.yml` has correct route definitions
3. **Check logs**: Look for Spring Cloud Gateway startup errors in Railway logs
