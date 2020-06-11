package com.mycompany.learnSystem.model.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String task_name;

    @Column
    private String task_description; // (nullable = false)

    @Column(updatable = false)
    @CreationTimestamp
    private LocalDateTime created_at;

    @ManyToOne
    @JoinColumn
    private User user;

    @OneToMany(mappedBy = "task")
    private List<Submission> submissions;

    public List<Submission> getSubmissions() {
        return this.submissions;
    }
    public Integer getSubmissionsCount() { return this.submissions.size(); }
}