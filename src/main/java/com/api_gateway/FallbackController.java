package com.api_gateway;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/fallback")
public class FallbackController {

    @GetMapping
    public ResponseEntity<Map<String, Object>> fallback() {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(Map.of(
                    "error", "Service temporarily unavailable",
                    "message", "Backend service is currently down. Please try again later.",
                    "status", 503,
                    "timestamp", System.currentTimeMillis()
                ));
    }
}
