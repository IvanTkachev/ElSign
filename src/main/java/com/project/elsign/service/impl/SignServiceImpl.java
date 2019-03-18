package com.project.elsign.service.impl;

import com.project.elsign.model.Document;
import com.project.elsign.model.Sign;
import com.project.elsign.repository.SignRepository;
import com.project.elsign.service.DocumentService;
import com.project.elsign.service.SignService;
import com.project.elsign.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SignServiceImpl implements SignService {

    @Autowired
    SignRepository signRepository;

    @Autowired
    UserService userService;

    @Autowired
    DocumentService documentService;

    @Override
    public List<Sign> getAllSign() {
        return signRepository.findAll();
    }

    @Override
    public List<Sign> getSignByUsername(String username) {
        return signRepository.getSignBySigner(userService.findByUsername(username).getId().toString());
    }

    @Override
    public List<Sign> getSignByDocument(Document document) {
        return signRepository.getSignByDocument(document.getId().toString());
    }

    @Override
    public void update(Sign sign) {
        signRepository.save(sign);
    }

    @Override
    public void save(Sign sign) {
        signRepository.save(sign);
    }

    @Override
    public Sign getSignBySignerAndDocument(String userId, String documentId) {
        return signRepository.getSignBySignerAndDocument(userId, documentId);
    }

    @Override
    public Sign getSignById(Long id) {
        return signRepository.getOne(id);
    }

    @Override
    public void delete(Sign sign) {
        signRepository.delete(sign);
    }


}
