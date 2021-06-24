package com.codesquad.issuetracker.auth.dto;

public enum Type {
    IOS("ios"),
    FE("fe");

    private final String type;

    Type(String type) {
        this.type = type;
    }

    public static boolean isFe(String type) {
        return FE.type.equals(type);
    }

    public static boolean isIos(String type) {
        return IOS.type.equals(type);
    }
}
