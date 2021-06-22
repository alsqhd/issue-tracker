package com.codesquad.issuetracker.milestone.service;

import com.codesquad.issuetracker.common.exception.EntityNotFoundException;
import com.codesquad.issuetracker.milestone.domain.Milestone;
import com.codesquad.issuetracker.milestone.domain.Milestones;
import com.codesquad.issuetracker.milestone.dto.MilestoneRequest;
import com.codesquad.issuetracker.milestone.dto.MilestoneResponse;
import com.codesquad.issuetracker.milestone.dto.MilestoneResponses;
import com.codesquad.issuetracker.milestone.repository.MilestoneRepositoryImpl;
import org.springframework.stereotype.Service;

@Service
public class MilestoneService {

    private final MilestoneRepositoryImpl milestoneRepository;

    public MilestoneService(MilestoneRepositoryImpl milestoneRepository) {
        this.milestoneRepository = milestoneRepository;
    }

    public MilestoneResponses readAll() {
        Milestones milestones = milestoneRepository.readAll();

        return MilestoneResponses.from(milestones);
    }

    public MilestoneResponse create(MilestoneRequest milestoneRequest) {
        Milestone savedMilestone = milestoneRepository.save(milestoneRequest.toEntity());

        return MilestoneResponse.from(savedMilestone);
    }

    public MilestoneResponse update(long id, MilestoneRequest milestoneRequest) {
        Milestone savedMilestone = milestoneRepository.readById(id)
                                            .orElseThrow(() -> new EntityNotFoundException());

        Milestone updatedMilestone = milestoneRepository.save(savedMilestone.update(milestoneRequest.toEntity()));

        return MilestoneResponse.from(updatedMilestone);
    }

    public void delete(long id) {
        milestoneRepository.deleteById(id);
    }
}
