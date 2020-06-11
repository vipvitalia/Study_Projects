package com.mycompany.learnSystem.controllers;

import com.mycompany.learnSystem.model.entities.Submission;
import com.mycompany.learnSystem.model.entities.Task;
import com.mycompany.learnSystem.model.entities.User;
import com.mycompany.learnSystem.model.repositories.SubmissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;

@Controller
@RequestMapping("/submissions")
public class SubmissionController {
    @Autowired
    private SubmissionRepository submissionRepository;

    @GetMapping("/{id}")
    public String getSubmission(@PathVariable Integer id, Model model) {
        model.addAttribute("submission", submissionRepository.findById(id).get());
        return "submission";
    }

    @GetMapping("/new_submit")
    public String createNew() {
        return "new_submit";
    }

    @PostMapping("/{id}/evaluate")
    public String evaluate(@PathVariable Integer id, @Valid Submission submission, BindingResult bindingResult, ModelMap modelMap, @RequestParam(value="grade", required = true) Integer grade) throws Exception {
        if (bindingResult.hasErrors()) {
            modelMap.put(BindingResult.class.getName() + ".subject", bindingResult);
            return "new_submit";
        }

        Submission oldSubmission = submissionRepository.findById(id).get();
        oldSubmission.setGrade(grade);
        submissionRepository.save(oldSubmission);
        return "redirect:/tasks";
    }

//    @GetMapping("/{id}/submissions")
//    public String getTaskSubmissions(@PathVariable Integer id, Model model) {
//        model.addAttribute("task", taskRepository.findById(id).get());
//        return "task";
//    }
}

