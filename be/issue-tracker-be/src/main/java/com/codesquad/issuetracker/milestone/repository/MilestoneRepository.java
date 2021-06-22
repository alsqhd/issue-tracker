package com.codesquad.issuetracker.milestone.repository;

import com.codesquad.issuetracker.milestone.domain.Milestone;
import com.codesquad.issuetracker.milestone.domain.Milestones;

import java.util.Optional;

public interface MilestoneRepository {
    Milestones readAll();

    Optional<Milestone> readById(long id);

    Milestone save(Milestone milestone);

    void deleteById(long id);
}
