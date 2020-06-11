package com.mycompany.learnSystem.model.repositories;

import com.mycompany.learnSystem.model.entities.Budget;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BudgetRepository extends CrudRepository<Budget, Integer> {
}
