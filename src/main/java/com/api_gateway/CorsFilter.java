package com.api_gateway;

import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.List;

@Component
public class CorsFilter implements GlobalFilter, Ordered {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        return chain.filter(exchange)
                .then(Mono.fromRunnable(() -> {
                    HttpHeaders headers = exchange.getResponse().getHeaders();
                    
                    // Remove duplicate CORS headers from backend
                    List<String> accessControlAllowOrigin = headers.get(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN);
                    if (accessControlAllowOrigin != null && accessControlAllowOrigin.size() > 1) {
                        // Keep only the first value
                        String firstValue = accessControlAllowOrigin.get(0);
                        headers.remove(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN);
                        headers.add(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, firstValue);
                    }
                    
                    // Ensure CORS headers are set correctly
                    if (!headers.containsKey(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN)) {
                        headers.add(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "https://www.langlearn.top");
                    }
                }));
    }

    @Override
    public int getOrder() {
        return Ordered.LOWEST_PRECEDENCE;
    }
}
