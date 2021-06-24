package com.codesquad.issuetracker.auth.dto;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;

@PropertySource(value = "classpath:auth.properties")
public class GitHubOAuth {

    @Value("${client_id}")
    private static String clientId;

    @Value("${client_secret}")
    private static String clientSecret;

    private static String code;
}
