package com.project.elsign.repository;

import com.project.elsign.model.Sign;
import com.project.elsign.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SignRepository extends JpaRepository<Sign, Long> {

    List<Sign> getSignBySigner(String userId);

    List<Sign> getSignByDocument(String documentId);

    Sign getSignBySignerAndDocument(String userIf, String documentId);
}
