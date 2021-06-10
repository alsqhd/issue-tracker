package com.codesquad.issuetracker.issue;

import com.codesquad.issuetracker.comment.CommentResponse;
import com.codesquad.issuetracker.comment.Emoji;
import com.codesquad.issuetracker.label.LabelResponse;
import com.codesquad.issuetracker.milestone.MileStoneDummyData;
import com.codesquad.issuetracker.milestone.MileStoneResponse;
import com.codesquad.issuetracker.user.UserResponse;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

public class IssueDummyData {
    private IssueDummyData() {
    }

    public static List<IssueResponse> issueResponses() {
        return Arrays.asList(
                IssueResponse.builder()
                        .id(1L)
                        .number(1L)
                        .title("title")
                        .description("description설명")
                        .hasSameAuthorComments(true)
                        .createDateTime(LocalDateTime.now())
                        .author(userFreddie())
                        .assignees(new HashSet<>(Arrays.asList(
                                userFreddie(),
                                userHiro()
                        )))
                        .labels(new HashSet<>(Arrays.asList(
                                labelBe()
                        )))
                        .milestone(MileStoneDummyData.MileStoneResponse())
                        .build()
        );
    }

    public static IssueDetailResponse issueDetailResponse() {
        return IssueDetailResponse.builder()
                       .id(1L)
                       .number(1L)
                       .title("title")
                       .createDateTime(LocalDateTime.now())
                       .author(userFreddie())
                       .assignees(Arrays.asList(
                               userFreddie(),
                               userHiro()
                       ))
                       .labels(Arrays.asList(
                               labelBe()
                       ))
                       .milestone(MileStoneDummyData.MileStoneResponse())
                       .mainComment(CommentResponse.builder()
                                            .id(1L)
                                            .author(userFreddie())
                                            .contents("comment1")
                                            .createDateTime(LocalDateTime.now())
                                            .emojis(new HashSet<>(Arrays.asList(
                                                    Emoji.builder()
                                                            .value("😀")
                                                            .count(2)
                                                            .build(),
                                                    Emoji.builder()
                                                            .value("😂")
                                                            .count(2)
                                                            .build()
                                            )))
                                            .build())
                       .build();
    }

    private static UserResponse userFreddie() {
        return UserResponse.builder()
                       .id(1L)
                       .email("freddie@freddie.com")
                       .name("freddie")
                       .build();
    }

    private static UserResponse userHiro() {
        return UserResponse.builder()
                       .id(2L)
                       .email("hiro@hiro.com")
                       .name("hiro")
                       .build();
    }

    private static LabelResponse labelBe() {
        return LabelResponse.builder()
                       .id(1L)
                       .name("be")
                       .description("label for backend")
                       .color("#1679CF")
                       .build();
    }

}
