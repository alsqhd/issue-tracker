package com.codesquad.issuetracker.auth.dto;

import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonSetter;

public class GitHubAccessTokenResponse {
      @JsonProperty("access_token")
      private String accessToken;

      @JsonProperty("token_type")
      private String tokenType;

      @JsonProperty("scope")
      private String scope;

      public GitHubAccessTokenResponse() {
      }

      public GitHubAccessTokenResponse(String accessToken, String tokenType, String scope) {
            this.accessToken = accessToken;
            this.tokenType = tokenType;
            this.scope = scope;
      }

      public String getScope() {
            return scope;
      }

      public String getTokenType() {
            return tokenType;
      }

      public String getAccessToken() {
            return accessToken;
      }

      @JsonSetter("access_token")
      public void setAccessToken(String accessToken) {
            this.accessToken = accessToken;
      }


      @JsonSetter("token_type")
      public void setTokenType(String tokenType) {
            this.tokenType = tokenType;
      }



      @JsonSetter("scope")
      public void setScope(String scope) {
            this.scope = scope;
      }

}
