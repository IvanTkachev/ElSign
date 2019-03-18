package com.project.elsign.service;

import java.io.File;
import java.security.Key;

public interface RsaService {

    byte[] encrypt(String original, Key privateKey);

    byte[] decrypt(byte[] encrypted, Key publicKey);

    String getMD5Hash(File file);

}
