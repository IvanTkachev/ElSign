package com.project.elsign.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Set;

@Entity
@Transactional
@Table(name = "document")
public class Document {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "link")
    private String link;

    @ManyToMany(
            mappedBy = "ownDocuments",
            fetch = FetchType.EAGER
    )
    private Set<User> owners;

    @ManyToMany(
            mappedBy = "signDocuments",
            fetch = FetchType.EAGER
    )
    private Set<User> signers;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Set<User> getSigners() {
        return signers;
    }

    public void setSigners(Set<User> signers) {
        this.signers = signers;
    }

    public Set<User> getOwners() {
        return owners;
    }

    public void setOwners(Set<User> owners) {
        this.owners = owners;
    }
}
