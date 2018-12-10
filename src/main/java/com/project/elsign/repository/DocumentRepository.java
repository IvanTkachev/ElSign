package com.project.elsign.repository;

import com.project.elsign.model.Document;
import com.project.elsign.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DocumentRepository extends JpaRepository<Document, Long> {

    List<Document> findByOwners(User user);

    List<Document> findBySigners(User user);

    Document getByNameAndLink(String name, String link);
}
