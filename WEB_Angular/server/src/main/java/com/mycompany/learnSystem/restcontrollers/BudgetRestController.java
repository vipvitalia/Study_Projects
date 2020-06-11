package com.mycompany.learnSystem.restcontrollers;

import com.mycompany.learnSystem.model.entities.Budget;
import com.mycompany.learnSystem.model.repositories.BudgetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.NoSuchElementException;
import java.util.Optional;

@RestController
@RequestMapping("/api/budget")
public class BudgetRestController {

    @Autowired
    private BudgetRepository budgetRepository;

    @GetMapping("")
    public ResponseEntity<Iterable<Budget>> getAll() {
        return ResponseEntity.ok(budgetRepository.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Budget> getBudgetById(@PathVariable("id") int id) {
        try {
            Budget pet = budgetRepository.findById(id).get();
            return ResponseEntity.ok(pet);
        } catch (NoSuchElementException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("")
    public ResponseEntity<Budget> post(@RequestBody Budget budget) {
        return ResponseEntity.ok(budgetRepository.save(budget));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Budget> update
            (@PathVariable Integer id,
             @RequestBody Budget budget) {
        Optional<Budget> oBudget = budgetRepository.findById(id);
        if (oBudget.isPresent()) {
            budget.setId(id);
            return ResponseEntity.ok(budgetRepository.save(budget));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Budget> delete
            (@PathVariable Integer id) {
        Optional<Budget> oBudget = budgetRepository.findById(id);
        if (oBudget.isPresent()) {
            budgetRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
