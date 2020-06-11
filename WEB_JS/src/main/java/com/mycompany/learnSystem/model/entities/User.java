package com.mycompany.learnSystem.model.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private Role role;

    @Column(nullable = false)
    private boolean enabled;

    public enum Role {
        ROLE_GUEST, ROLE_USER, ROLE_ADMIN
    }

    @OneToMany(mappedBy = "user")
    private List<Submission> submissions;

    @OneToMany(mappedBy = "user")
    private List<Task> tasks;

    public List<Task> getTasks() {
        return this.tasks;
    }
}