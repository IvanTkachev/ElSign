package com.project.elsign.service;

import com.project.elsign.model.Document;
import com.project.elsign.model.Sign;
import org.springframework.stereotype.Service;

import java.util.List;

public interface SignService {

    List<Sign> getAllSign();

    List<Sign> getSignByUsername(String username);

    List<Sign> getSignByDocument(Document document);

    void update(Sign sign);

    void save(Sign sign);

    Sign getSignBySignerAndDocument(String userId, String documentId);
}
