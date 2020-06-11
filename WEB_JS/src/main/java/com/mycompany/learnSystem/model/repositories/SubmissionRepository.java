package com.mycompany.learnSystem.model.repositories;

import com.mycompany.learnSystem.model.entities.Submission;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubmissionRepository extends CrudRepository<Submission, Integer> {

}

