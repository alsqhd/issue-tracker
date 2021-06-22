package com.codesquad.issuetracker.milestone.dto;

import com.codesquad.issuetracker.milestone.domain.Milestone;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;

@Data
public class MilestoneRequest {

    @NotEmpty
    private String name;
    private String description;
    private LocalDate dueDate;
    private boolean isClosed;

    public Milestone toEntity() {
        return Milestone.builder()
                        .name(name)
                        .description(description)
                        .dueDate(dueDate)
                        .isClosed(isClosed)
                        .build();
    }
}
