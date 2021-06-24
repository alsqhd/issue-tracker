package com.codesquad.issuetracker.auth.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
import com.codesquad.issuetracker.auth.exception.JWTCreationException;
import com.codesquad.issuetracker.auth.exception.JwtException;
import com.codesquad.issuetracker.user.UserDto;
import lombok.Data;

@Data
public class JwtUtil {
    private static final String JWT_SECRET = "jwtSecret";
    private static final String JWT_ISSUER = "jwtIssuer";
    private static final String USER_LOGIN = "login";
    private static final String USER_NAME = "name";
    private static final String USER_AVATAR = "avatar";
    private static final Algorithm algorithmHS = Algorithm.HMAC256(JWT_SECRET);

    public static String createJwt(UserDto user) {
        try {
            return JWT.create()
                    .withIssuer(JWT_ISSUER)
                    .withClaim(USER_LOGIN, user.getLogin())
                    .withClaim(USER_NAME, user.getName())
                    .withClaim(USER_AVATAR, user.getAvatarUrl())
                    .sign(algorithmHS);
        } catch (JWTCreationException exception) {
            throw new JwtException("JWT 생성 실패");
        }
    }

    public static UserDto decodeJwt(String token) throws JwtException {
        try {
            JWTVerifier verifier = JWT.require(algorithmHS)
                    .withIssuer(JWT_ISSUER)
                    .build();

            DecodedJWT jwt = verifier.verify(token);

            String login = jwt.getClaim(USER_LOGIN).asString();
            String name = jwt.getClaim(USER_NAME).asString();
            String avatarUri = jwt.getClaim(USER_AVATAR).asString();

            return new UserDto(login, name, avatarUri);
        } catch (JWTVerificationException exception) {
            throw new JwtException("잘못된 jwt 입니다.");
        }
    }

}
