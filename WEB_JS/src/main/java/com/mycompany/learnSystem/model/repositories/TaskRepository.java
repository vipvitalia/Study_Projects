package com.mycompany.learnSystem.model.repositories;

import com.mycompany.learnSystem.model.entities.Task;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskRepository extends CrudRepository<Task, Integer> {
    // Extra query options
    // Foo findByPropertyX(String propertyX);
    // Foo findByPropertyXAndPropertyY(String propertyX, String propertyY);
    // List<Foo> findAllByPropertyZ(String propertyZ);

    // @Query("select f.baz from Foo f where f.baz = ?1")
    // List<Foo> findBySomething(String baz);


}

