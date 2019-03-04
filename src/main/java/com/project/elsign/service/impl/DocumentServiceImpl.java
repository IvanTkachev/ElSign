package com.project.elsign.service.impl;

import com.project.elsign.model.Document;
import com.project.elsign.repository.DocumentRepository;
import com.project.elsign.repository.UserRepository;
import com.project.elsign.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DocumentServiceImpl implements DocumentService{

    @Autowired
    DocumentRepository documentRepository;

    @Autowired
    UserRepository userRepository;

    @Override
    public List<Document> getDocumentsByOwnerUsername(String username) {
        return documentRepository.findByOwners(userRepository.findByUsername(username));
    }

    @Override
    public Document getDocumentById(Long id) {
        return documentRepository.getOne(id);
    }

    @Override
    public List<Document> getAllDocuments() {
        return documentRepository.findAll();
    }

    @Override
    public void updateDocument(Document document) {
        documentRepository.save(document);
    }

    @Override
    public List<Document> getSignDocumentsByUsername(String username) {
        return documentRepository.findBySigners(userRepository.findByUsername(username));
    }

    @Override
    public void save(Document document) {
        documentRepository.save(document);
    }

    @Override
    public Document getByNameAndLink(String name, String link) {
        return documentRepository.getByNameAndLink(name, link);
    }

}
