package com.codesquad.issuetracker.milestone.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import java.time.LocalDate;

@Builder
@Getter
@AllArgsConstructor
public class Milestone {
    private Long id;
    private String name;
    private String description;
    private LocalDate dueDate;
    private boolean isClosed;
    private int openedIssueCount;
    private int closedIssueCount;

    public Milestone update(Milestone milestoneForUpdate) {
        name = milestoneForUpdate.getName();
        description = milestoneForUpdate.getDescription();
        dueDate = milestoneForUpdate.getDueDate();
        isClosed = milestoneForUpdate.isClosed();
        openedIssueCount = milestoneForUpdate.getClosedIssueCount();
        closedIssueCount = milestoneForUpdate.getClosedIssueCount();

        return this;
    }
}
