package com.mycompany.learnSystem.controllers;

import com.mycompany.learnSystem.model.entities.Task;
import com.mycompany.learnSystem.model.entities.User;
import com.mycompany.learnSystem.model.repositories.SubmissionRepository;
import com.mycompany.learnSystem.model.repositories.TaskRepository;
import com.mycompany.learnSystem.model.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/tasks")
public class TaskController {
    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("")
    public String getAll(Model model, Principal principal) {
        String username = principal.getName();
        User user = userRepository.findByUsername(username).get();
        List<Task> tasks = user.getTasks();

        model.addAttribute("title", "Task list");
        model.addAttribute("tasks", tasks);
        return "tasks";
    }

    @GetMapping("/new_task")
    public String createForm(Model model) {
        model.addAttribute("task", new Task());
        return "new_task";
    }

    @PostMapping("/new_task")
    public String createTask(@Valid Task task, BindingResult bindingResult, Principal principal, ModelMap modelMap) throws Exception {
        if (bindingResult.hasErrors()) {
            modelMap.put(BindingResult.class.getName() + ".subject", bindingResult);
            return "new_task";
        }

        String username = principal.getName();
        User user = userRepository.findByUsername(username).get();
        task.setUser(user);

        taskRepository.save(task);
        return "redirect:/tasks";
        // validate
        // on error --> show issue detail page
        // on success --> save message and redirect to issue detail page
    }

    @GetMapping("/{id}")
    public String getTask(@PathVariable Integer id, Model model) {
        Task task = taskRepository.findById(id).get();
        model.addAttribute("task", task);
        model.addAttribute("submissions", task.getSubmissions());
        return "task";
    }


}

