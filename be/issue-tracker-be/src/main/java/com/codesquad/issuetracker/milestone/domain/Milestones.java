package com.codesquad.issuetracker.milestone.domain;

import com.codesquad.issuetracker.label.domain.Label;
import com.codesquad.issuetracker.label.domain.Labels;
import lombok.Data;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

@Data(staticConstructor = "from")
public class Milestones {
    private final List<Milestone> milestones;

    public static Milestones of(Milestone... milestones) {
        return from(new ArrayList<>(Arrays.asList(milestones)));
    }

    public Stream<Milestone> stream() {
        return milestones.stream();
    }
}
