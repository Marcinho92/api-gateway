# API Gateway

This is a Spring Cloud Gateway application that acts as an API gateway for your language learning backend.

## Recent Fixes

### Issue Fixed
- **Deprecated dependency**: Replaced `spring-cloud-starter-gateway` with `spring-cloud-starter-gateway-server-webflux`
- **Missing RequestRateLimiter**: Removed rate limiting to fix startup issues

### Changes Made
1. Updated `pom.xml`:
   - Replaced deprecated gateway starter with `spring-cloud-starter-gateway-server-webflux`
   - Removed Redis dependency

2. Updated `application.yml`:
   - Removed Redis configuration
   - Removed rate limiting configuration to ensure stable startup
   - Configured for Railway deployment

## Current Configuration

### API Gateway Routes
- **Main API Route**: `/api/**` → Backend service
- **Health Check**: `/actuator/health` → Backend service (no rate limiting)
- **CORS**: Configured for specific origins with duplicate header removal

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
