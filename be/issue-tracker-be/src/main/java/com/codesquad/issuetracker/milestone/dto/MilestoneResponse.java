package com.codesquad.issuetracker.milestone.dto;

import com.codesquad.issuetracker.milestone.domain.Milestone;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDate;

@Data
@EqualsAndHashCode(of = {"id"})
@Builder
public class MilestoneResponse {
    private Long id;
    private String name;
    private String description;
    private LocalDate dueDate;
    private boolean isClosed;
    private int openedIssueCount;
    private int closedIssueCount;

    public static MilestoneResponse from(Milestone milestone) {
        return MilestoneResponse.builder()
                .id(milestone.getId())
                .name(milestone.getName())
                .description(milestone.getDescription())
                .dueDate(milestone.getDueDate())
                .isClosed(milestone.isClosed())
                .openedIssueCount(milestone.getOpenedIssueCount())
                .closedIssueCount(milestone.getClosedIssueCount())
                .build();
    }
}
