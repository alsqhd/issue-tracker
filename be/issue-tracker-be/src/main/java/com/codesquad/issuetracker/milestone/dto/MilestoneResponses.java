package com.codesquad.issuetracker.milestone.dto;

import com.codesquad.issuetracker.milestone.domain.Milestones;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Data;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Data(staticConstructor = "from")
public class MilestoneResponses {

    @JsonValue
    private final Set<MilestoneResponse> milestoneResponses;

    public static MilestoneResponses from(Collection<MilestoneResponse> milestoneResponses) {
        return new MilestoneResponses(new HashSet<>(milestoneResponses));
    }

    public static MilestoneResponses from(Milestones milestoneEntities) {
        Set<MilestoneResponse> milestoneResponses = milestoneEntities.stream()
                .map(MilestoneResponse::from)
                .collect(Collectors.toSet());

        return MilestoneResponses.from(milestoneResponses);
    }
}
