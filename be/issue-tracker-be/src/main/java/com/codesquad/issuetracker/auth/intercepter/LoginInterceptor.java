package com.codesquad.issuetracker.auth.intercepter;

import com.codesquad.issuetracker.auth.exception.LoginRequired;
import com.codesquad.issuetracker.auth.exception.AuthenticationException;
import com.codesquad.issuetracker.auth.util.JwtUtil;
import com.codesquad.issuetracker.user.UserDto;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static org.springframework.http.HttpHeaders.AUTHORIZATION;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (isLoginRequired(handler)) {
            authenticate(request);
        }
        return true;
    }

    private boolean isLoginRequired(Object handler) {
        return handler instanceof HandlerMethod
                && ((HandlerMethod) handler).hasMethodAnnotation(LoginRequired.class);
    }

    private void authenticate(HttpServletRequest request) {
        String[] splitAuth = request.getHeader(AUTHORIZATION).split(" ");
        String tokenType = splitAuth[0].toLowerCase();
        if (splitAuth.length < 1 || !tokenType.equals("bearer")) {
            throw new AuthenticationException("잘못된 Authorization Header 입니다.");
        }
        UserDto userDto = JwtUtil.decodeJwt(splitAuth[1]);
        request.setAttribute("user", userDto);
    }
}
