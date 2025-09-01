# API Gateway

This is a Spring Cloud Gateway application that acts as an API gateway for your language learning backend.

## Recent Fixes

### Issue Fixed
- **Deprecated dependency**: Replaced `spring-cloud-starter-gateway` with `spring-cloud-starter-gateway-server-webflux`
- **Missing RequestRateLimiter**: Configured in-memory rate limiting functionality

### Changes Made
1. Updated `pom.xml`:
   - Replaced deprecated gateway starter with `spring-cloud-starter-gateway-server-webflux`
   - Removed Redis dependency (using in-memory rate limiting)

2. Updated `application.yml`:
   - Removed Redis configuration
   - Configured in-memory rate limiting with IP-based key resolver
   - Configured for Railway deployment

3. Added configuration classes:
   - `RateLimiterConfig.java` - In-memory rate limiting configuration

## Rate Limiting Configuration

### In-Memory Rate Limiter (current setup)
- **Default Rate**: 10 requests per second
- **Key**: IP address based
- **Storage**: In-memory (resets on restart)
- **Configuration**: Uses Spring Cloud Gateway's default rate limiter

## Environment Variables for Railway

```bash
# Required
BACKEND_URL=https://your-backend-url.up.railway.app

# Optional
PORT=8080
```

## Testing

After deployment, you can test the rate limiting:

```bash
# Test rate limiting (should work for first 10 requests per second)
curl -X GET https://your-gateway-url.up.railway.app/api/health

# Test health endpoint (no rate limiting)
curl -X GET https://your-gateway-url.up.railway.app/actuator/health
```

## Troubleshooting

If you still get the "Unable to find GatewayFilterFactory with name RequestRateLimiter" error:

1. **Check dependencies**: Ensure `spring-cloud-starter-gateway-server-webflux` is in your `pom.xml`
2. **Check configuration**: Verify `RateLimiterConfig.java` is present
3. **Check logs**: Look for Spring Cloud Gateway startup errors in Railway logs
