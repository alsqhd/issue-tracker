package com.codesquad.issuetracker.auth.dto;

public class AuthRequest {
    private String code;

    public AuthRequest(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
