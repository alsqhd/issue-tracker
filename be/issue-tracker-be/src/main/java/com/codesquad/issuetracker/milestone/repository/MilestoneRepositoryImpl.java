package com.codesquad.issuetracker.milestone.repository;

import com.codesquad.issuetracker.milestone.domain.Milestone;
import com.codesquad.issuetracker.milestone.domain.Milestones;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class MilestoneRepositoryImpl implements MilestoneRepository{
    @Override
    public Milestones readAll() {
        return null;
    }

    @Override
    public Optional<Milestone> readById(long id) {
        return Optional.empty();
    }

    @Override
    public Milestone save(Milestone milestone) {
        return null;
    }

    @Override
    public void deleteById(long id) {

    }
}
