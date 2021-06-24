package com.codesquad.issuetracker.auth.exception;

public class JWTCreationException extends RuntimeException{
    public JWTCreationException(String message) {
        super(message);
    }
}
