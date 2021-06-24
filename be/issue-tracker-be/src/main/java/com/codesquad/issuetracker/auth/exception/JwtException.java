package com.codesquad.issuetracker.auth.exception;

public class JwtException extends RuntimeException {
    public JwtException(String message) {
        super(message);
    }
}
