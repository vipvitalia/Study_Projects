package com.mycompany.learnSystem.model.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class Submission {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

//    @Column(nullable = false)
//    private String author;

    @Column(nullable = false)
    private String solution;

    @Column
    private Integer grade;

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    @Column(updatable = false)
    @CreationTimestamp
    private LocalDateTime created_at;

    @ManyToOne
    @JoinColumn
    private Task task;

    @ManyToOne
    @JoinColumn
    private User user;
}