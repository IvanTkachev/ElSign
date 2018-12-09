package com.project.elsign.model;

import javax.persistence.*;

@Entity
@Table(name = "sign")
public class Sign {
    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "date_sign")
    private String signDate;



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

}
