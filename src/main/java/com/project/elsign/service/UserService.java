package com.project.elsign.service;

import com.project.elsign.model.User;

public interface UserService {

    void save(User user);

    User findByUsername(String username);

    User findByEmail(String email);

    void update(User user);
}
