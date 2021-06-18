package com.codesquad.issuetracker.issue.dto;

import com.codesquad.issuetracker.comment.dto.CommentResponse;
import com.codesquad.issuetracker.comment.dto.CommentResponses;
import com.codesquad.issuetracker.issue.domain.Issue;
import com.codesquad.issuetracker.label.dto.LabelResponses;
import com.codesquad.issuetracker.milestone.dto.MilestoneResponse;
import com.codesquad.issuetracker.user.dto.UserResponse;
import com.codesquad.issuetracker.user.dto.UserResponses;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@Data
@EqualsAndHashCode(of = {"id"})
@Builder
public class IssueDetailResponse {
    private Long id;
    private long number;
    private String title;
    private boolean isClosed;
    private LocalDateTime createDateTime;
    private UserResponse author;
    private UserResponses assignees;
    private LabelResponses labels;
    private MilestoneResponse milestone;
    private CommentResponse mainComment;
    private CommentResponses comments;

    public static IssueDetailResponse from(Issue issue) {
        return IssueDetailResponse.builder()
                       .id(issue.getId())
                       .number(issue.getNumber())
                       .title(issue.getTitle())
                       .isClosed(issue.isClosed())
                       .createDateTime(issue.getCreateDateTime())
                       .author(UserResponse.from(issue.getAuthor()))
                       .assignees(UserResponses.from(issue.getAssignees()))
                       .labels(LabelResponses.from(issue.getLabels()))
                       .milestone(MilestoneResponse.from(issue.getMilestone()))
                       .mainComment(CommentResponse.from(issue.getMainComment()))
                       .comments(CommentResponses.from(issue.getComments()))
                       .build();
    }
}
