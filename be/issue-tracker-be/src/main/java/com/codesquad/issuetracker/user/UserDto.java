package com.codesquad.issuetracker.user;

import com.fasterxml.jackson.annotation.JsonProperty;

public class UserDto {
    @JsonProperty("login")
    private String login;

    @JsonProperty("avatar_url")
    private String avatarUrl;

    @JsonProperty("name")
    private String name;

    public UserDto() {
    }

    public UserDto(String login, String avatarUrl, String name) {
        this.login = login;
        this.avatarUrl = avatarUrl;
        this.name = name;
    }

    public String getLogin() {
        return login;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public String getName() {
        return name;
    }

}
