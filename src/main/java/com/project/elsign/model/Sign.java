package com.project.elsign.model;

import javax.persistence.*;
import java.security.Key;
import java.util.Set;

@Entity
@Table(name = "sign")
public class Sign {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_sign")
    private String signDate;

    @Column(name = "id_user")
    private String signer;

    @Column(name = "id_document")
    private String document;

    @Column(name = "public_key")
    private byte[] publicKey;

    @Column(name = "enc_hash")
    private byte[] encHash;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSignDate() {
        return signDate;
    }

    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }

    public String getSigner() {
        return signer;
    }

    public void setSigner(String signer) {
        this.signer = signer;
    }

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public byte[] getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(byte[] publicKey) {
        this.publicKey = publicKey;
    }

    public byte[] getEncHash() {
        return encHash;
    }

    public void setEncHash(byte[] encHash) {
        this.encHash = encHash;
    }
}
