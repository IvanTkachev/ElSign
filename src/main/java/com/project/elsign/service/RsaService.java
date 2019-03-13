package com.project.elsign.service;

import java.security.Key;

public interface RsaService {

    byte[] encrypt(String original, Key privateKey);

    byte[] decrypt(byte[] encrypted, Key publicKey);

}
