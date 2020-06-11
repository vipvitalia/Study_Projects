package com.mycompany.learnSystem.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;

@Controller
public class IndexController {

    @RequestMapping("/")
    public String index() {
        return "index";
    }

//    @GetMapping("/test1")
//    public String test1(Model model) {
//        model.addAttribute("tasks", Arrays.asList(
//                "Brad Pitt",
//                "Bruce Willis",
//                "Benedict Cumberbatch"
//        ));
//        return "list";
//    }

}