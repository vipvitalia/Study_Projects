package com.mycompany.learnSystem;

import com.mycompany.learnSystem.model.entities.User;
import com.mycompany.learnSystem.model.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@SpringBootApplication
public class LearnSystemApplication {

	public static void main(String[] args) {
		SpringApplication.run(LearnSystemApplication.class, args);
	}

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@EventListener
	public void seed(ContextRefreshedEvent event) {
		for(User user : userRepository.findAll()) {
			user.setPassword(passwordEncoder.encode(user.getPassword()));
			userRepository.save(user);
		}
	}

}
