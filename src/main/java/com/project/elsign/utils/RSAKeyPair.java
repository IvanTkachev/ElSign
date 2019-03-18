package com.project.elsign.utils;

import com.project.elsign.model.constant.RSAConstants;

import java.security.KeyPair;
import java.security.KeyPairGenerator;

public class RSAKeyPair {

    public static KeyPair keyPairRSA() {
        KeyPairGenerator generator = null;
        try {
            generator = KeyPairGenerator.getInstance(RSAConstants.ALGORITHM);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (generator != null) {
            generator.initialize(RSAConstants.ALGORITHM_BITS);
            return generator.genKeyPair();
        }
        return null;
    }

}
